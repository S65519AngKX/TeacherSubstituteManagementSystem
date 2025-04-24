/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.LeaveDao;
import com.Dao.SubstitutionAssignmentDao;
import com.Dao.SubstitutionDao;
import com.Model.Leave;
import com.Model.Substitution;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.Database;

/**
 *
 * @author Khe Xin
 */
@WebServlet(name = "LeaveServlet", urlPatterns = {"/LeaveServlet"})
public class LeaveServlet extends HttpServlet {

    // Telegram Bot settings
    private static final String TELEGRAM_BOT_TOKEN = "7875648625:AAHuc62etZLbotxvdUwvfKT9qCH1fBfGfk8";
    String CHAT_ID = null;  // Chat ID for the teacher(teacher need to get their user id first using the IDBOT from telegram)
    private LeaveDao LeaveDao;

    public void init() {
        LeaveDao = new LeaveDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("action"+action);

        try {
            switch (action) {
                case "save":
                    saveLeave(request, response);
                    break;
                case "delete":
                    deleteLeave(request, response);
                    break;
                case "update":
                    updateLeaveStatus(request, response);
                    break;
                default:
                    showLeaveForm(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void showLeaveForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        response.sendRedirect("LEAVE.jsp");
    }

    private void saveLeave(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        PrintWriter out = response.getWriter();

        int absentTeacherId = Integer.parseInt(request.getParameter("teacherId"));
        Date startDate = java.sql.Date.valueOf(request.getParameter("leaveStartDate"));
        Date endDate = java.sql.Date.valueOf(request.getParameter("leaveEndDate"));
        String reason = request.getParameter("leaveReason");
        String notes = request.getParameter("leaveNotes");
        String status = request.getParameter("leaveStatus");

        Leave leave = new Leave();
        leave.setAbsentTeacherID(absentTeacherId);
        leave.setLeaveStartDate(startDate);
        leave.setLeaveEndDate(endDate);
        leave.setLeaveReason(reason);
        leave.setLeaveNotes(notes);
        leave.setLeaveStatus(status);

        try ( Connection con = Database.getConnection()) {
            int result = LeaveDao.save(leave);
            if (result > 0) {
                out.print("<script>alert('Record saved successfully!');</script>");
                request.getRequestDispatcher("teacherLeaveHistory.jsp").include(request, response);
            } else {
                out.print("<script>alert('Sorry! Unable to save leave record.');</script>");
                request.getRequestDispatcher("LEAVE.jsp").include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void deleteLeave(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int leaveId = Integer.parseInt(request.getParameter("leaveId"));
        int status = LeaveDao.delete(leaveId);
        if (status > 0) {
            response.getWriter().print("<script>alert('Leave record deleted successfully!');</script>");
            request.getRequestDispatcher("leaveHistory.jsp").include(request, response);
        } else {
            response.getWriter().print("<script>alert('Sorry! Unable to delete leave record.');</script>");
            request.getRequestDispatcher("leaveHistory.jsp").include(request, response);
        }
    }

    private void updateLeaveStatus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        int leaveId = Integer.parseInt(request.getParameter("leaveId"));
        String status = request.getParameter("leaveStatus");
        Leave leave = LeaveDao.getLeaveDetailsByLeaveID(leaveId);

        try ( Connection con = Database.getConnection()) {
            con.setAutoCommit(false); // Start transaction

            int result = LeaveDao.updateLeaveStatus(leaveId, status, con);
            if (result > 0) {
                sendTelegramNotification(leave, status);  // Send notification to Telegram

                if (status.equalsIgnoreCase("Approved")) {
                    LocalDate currentDate = leave.getLeaveStartDate().toLocalDate(); // Convert SQL Date to LocalDate

                    while (!currentDate.isAfter(leave.getLeaveEndDate().toLocalDate())) { // Loop from startDate to endDate
                        Substitution substitution = new Substitution();
                        substitution.setSubstitutionDate(Date.valueOf(currentDate));
                        substitution.setLeaveID(leaveId);

                        int substitutionId = SubstitutionDao.save(substitution, con);
                        if (substitutionId <= 0) {
                            con.rollback();
                            out.print("<script>alert('Sorry! Unable to save substitution record.');</script>");
                            request.getRequestDispatcher("LEAVES.jsp").include(request, response);
                            return;
                        }
                        System.out.println("Calling createSubstitutionAssignmentsForLeave...");
                        SubstitutionAssignmentDao.createSubstitutionAssignmentsForLeave(substitutionId, leave.getAbsentTeacherID(), Date.valueOf(currentDate), con);
                        System.out.println(leave.getAbsentTeacherID());
                        System.out.println(leave.getLeaveStartDate());
                        System.out.println(leave.getLeaveEndDate());
                        System.out.println(leave.getAbsentTeacherID());

                        con.commit();
                        System.out.println("Commit successful!");

                        currentDate = currentDate.plusDays(1); // Move to the next date
                    }
                    con.commit();
                    out.print("<script>alert('Substitution assignments record saved successfully!');</script>");
                    request.getRequestDispatcher("LEAVES.jsp").include(request, response);
                } else {
                    con.commit();
                    response.sendRedirect("LEAVES.jsp");
                }

            } else {
                con.rollback(); // Ensure rollback if the leave update fails
                out.print("<script>alert('Unable to approve/reject the leave request.');</script>");
                request.getRequestDispatcher("LEAVES.jsp").include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("LEAVES.jsp");
        } finally {
            try ( Connection con = Database.getConnection()) {
                con.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    // send Telegram notification method
    private void sendTelegramNotification(Leave leave, String status) {
        try {
            //skip if the teacher does not have a telegram chat id
            if (leave.getTelegramId() == null || leave.getTelegramId().trim().isEmpty()) {
                return;
            }
            CHAT_ID = leave.getTelegramId();
            String message = "Dear " + leave.getTeacherName() + ",\n\nYour leave request (Leave ID: " + leave.getLeaveID()
                    + ") from " + leave.getLeaveStartDate() + " to " + leave.getLeaveEndDate() + " has been " + status + ".\n\nBest regards,\nPrincipal";

            // encode the message 
            String encodedMessage = URLEncoder.encode(message, "UTF-8");

            // Construct the Telegram URL
            String urlString = "https://api.telegram.org/bot" + TELEGRAM_BOT_TOKEN + "/sendMessage?chat_id=" + CHAT_ID + "&text=" + encodedMessage;
            System.out.println("URL: " + urlString); // debugging purpose

            // Create a URL object and open a connection
            URL url = new URL(urlString);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Set request method and headers
            connection.setRequestMethod("GET");
            connection.setDoOutput(true);

            // Send the request
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Success
                System.out.println("Telegram notification sent successfully.");
            } else {
                System.out.println("Failed to send Telegram notification. Response code: " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error sending Telegram notification: " + e.getMessage());
        }
    }
}
