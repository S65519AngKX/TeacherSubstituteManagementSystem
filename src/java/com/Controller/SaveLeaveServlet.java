/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.LeaveDao;
import com.Model.Leave;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
@WebServlet(name = "SaveLeaveServlet", urlPatterns = {"/SaveLeaveServlet"})
public class SaveLeaveServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
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

        int result = LeaveDao.save(leave);
        if (result > 0) {
            out.print("<script>alert('Record saved successfully!');</script>");
            request.getRequestDispatcher("teacherLeaveHistory.jsp").include(request, response);
        } else {
            out.print("<script>alert('Sorry! Unable to save leave record.');</script>");
           request.getRequestDispatcher("LEAVE.jsp").include(request, response);
        }

        out.close();
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
/**
 * Handles the HTTP <code>GET</code> method.
 *
 * @param request servlet request
 * @param response servlet response
 * @throws ServletException if a servlet-specific error occurs
 * @throws IOException if an I/O error occurs
 */
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
