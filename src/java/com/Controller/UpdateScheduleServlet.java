/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.ScheduleDao;
import com.Model.Schedule;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Khe Xin
 */
public class UpdateScheduleServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
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
