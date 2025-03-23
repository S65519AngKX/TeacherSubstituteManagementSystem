/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.ScheduleDao;
import com.Model.Schedule;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import util.Database;

/**
 *
 * @author Khe Xin
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
@WebServlet(name = "ScheduleServlet", urlPatterns = {"/ScheduleServlet"})
public class ScheduleServlet extends HttpServlet {

    private ScheduleDao ScheduleDao;

    public void init() {
        ScheduleDao = new ScheduleDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "save":
                    saveSchedule(request, response);
                    break;
                case "delete":
                    deleteSchedule(request, response);
                    break;
                case "update":
                    updateSchedule(request, response);
                    break;
                case "upload":
                    uploadScheduleFile(request, response);
                    break;
                default:
                    showSchedule(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void showSchedule(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        response.sendRedirect("SCHEDULE.jsp");
    }

    private void saveSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        String[] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"};
        boolean status = true;

        for (String day : daysOfWeek) {
            for (int period = 1; period <= 11; period++) {
                String subject = request.getParameter(day.toLowerCase() + "_" + period + "_subject");
                String className = request.getParameter(day.toLowerCase() + "_" + period + "_class");

                // Set subject and className to null if empty
                subject = (subject == null || subject.isEmpty()) ? null : subject;
                className = (className == null || className.isEmpty()) ? null : className;

                Schedule schedule = new Schedule();
                schedule.setScheduleDay(day);
                schedule.setSchedulePeriod(period);
                schedule.setScheduleSubject(subject);
                schedule.setClassName(className);
                schedule.setTeacherId(teacherId);

                if (ScheduleDao.save(schedule) <= 0) {
                    status = false;
                }
            }
        }

        // Redirect before any further output
        if (status) {
            out.print("<script>alert('Record saved successfully!');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        } else {
            out.print("<script>alert('Sorry! Unable to save schedule record.');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        }
        return;

    }

    private void deleteSchedule(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        int status = ScheduleDao.delete(teacherId);
        if (status > 0) {
            response.getWriter().print("<script>alert('Schedules deleted successfully!');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        } else {
            response.getWriter().print("<script>alert('Sorry! Unable to delete schedules.');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        }
    }

    private void updateSchedule(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        int teacherId = Integer.parseInt(request.getParameter("teacherId"));
        String[] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"};
        boolean status = true;

        for (String day : daysOfWeek) {
            for (int period = 1; period <= 11; period++) {
                int scheduleId = Integer.parseInt(request.getParameter(day.toLowerCase() + "_" + period + "_scheduleId"));
                String subject = request.getParameter(day.toLowerCase() + "_" + period + "_subject");
                String className = request.getParameter(day.toLowerCase() + "_" + period + "_class");

                // Set subject and className to null if empty
                subject = (subject == null || subject.isEmpty()) ? null : subject;
                className = (className == null || className.isEmpty()) ? null : className;
                Schedule schedule = new Schedule();
                schedule.setScheduleDay(day);
                schedule.setSchedulePeriod(period);
                schedule.setScheduleSubject(subject);
                schedule.setClassName(className);
                schedule.setTeacherId(teacherId);
                schedule.setScheduleId(scheduleId);

                if (ScheduleDao.update(schedule) <= 0) {
                    status = false;
                }
            }
        }

        // Redirect before any further output
        if (status) {
            out.print("<script>alert('Record updated successfully!');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        } else {
            out.print("<script>alert('Sorry! Unable to update schedule record.');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        }
        return;
    }

    private void uploadScheduleFile(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        // Retrieve uploaded CSV file
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();

        // Validate file 
        if (fileName == null || fileName.isEmpty() || !fileName.toLowerCase().endsWith(".csv")) {
            out.println("<script>alert('Invalid file! Please upload a CSV file.');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
            return;
        }

        // Save the uploaded file
        File fileLocation = new File("C:\\Users\\ACER\\Desktop\\KX\\UMT\\sem5\\assignment\\fyp\\S65519_TeacherSubstituteManagementSystem\\web\\csv");
        if (!fileLocation.exists()) {
            fileLocation.mkdirs();
        }

        File uploadedFile = new File(fileLocation, fileName);
        try ( InputStream fileContent = filePart.getInputStream();  FileOutputStream outputStream = new FileOutputStream(uploadedFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }

        // Read and process CSV file
        try ( BufferedReader lineReader = new BufferedReader(new FileReader(uploadedFile));  Connection connection = Database.getConnection()) {

            connection.setAutoCommit(false); // Disable auto-commit for batch processing

            String sql = "INSERT INTO schedule(scheduleDay,schedulePeriod,scheduleSubject,className,teacherId)VALUES(?,?,?,?,?)";
            try ( PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

                String lineText;
                int count = 0;

                lineReader.readLine(); // Skip header line

                while ((lineText = lineReader.readLine()) != null) {
                    String[] data = lineText.split(",");

                    if (data.length < 5) {
                        continue; //skip uneccesary content
                    }

                    preparedStatement.setString(1, data[0]);
                    preparedStatement.setInt(2, Integer.parseInt(data[1]));
                    preparedStatement.setString(3, data[2]);
                    preparedStatement.setString(4, data[3]);
                    preparedStatement.setInt(5, Integer.parseInt(data[4]));

                    preparedStatement.addBatch(); // Add to batch
                    count++;

                    // Execute batch every 500 records to avoid memory overflow
                    if (count % 500 == 0) {
                        preparedStatement.executeBatch();
                    }
                }

                // Execute remaining batch
                preparedStatement.executeBatch();
                connection.commit(); // Commit all changes

                out.print("<script>alert('" + count + " records saved successfully');</script>");
                request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("<script>alert('Sorry! Unable to save schedule record.');</script>");
            request.getRequestDispatcher("SCHEDULES.jsp").include(request, response);
        }
    }

}
