/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.ReportDao;
import com.Model.Report;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Khe Xin
 */
public class ReportServlet extends HttpServlet {

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
        // Read parameters from the request
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        Date start = null;
        Date end = null;
        if (startDate != null && !startDate.trim().isEmpty()) {
            start = Date.valueOf(startDate);
        }
        if (endDate != null && !endDate.trim().isEmpty()) {
            end = Date.valueOf(endDate);
        }

        try {
            List<Report> leaveRank = ReportDao.getLeaveRanking(start, end);
            request.setAttribute("leaveRanking", leaveRank);
            List<Report> subAssignRank = ReportDao.getSubstitutionAssignmentRanking(start, end);
            request.setAttribute("substitutionRanking", subAssignRank);
            List<Report> leaveReport = ReportDao.getLeaveReport(start, end);
            request.setAttribute("leaveReport", leaveReport);
            List<Report> subAssignList = ReportDao.getSubstitutionAssignmentReport(start, end);
            request.setAttribute("assgnReport", subAssignList);
            List<Report> leaveType = ReportDao.getLeaveTypePercentage(start, end);
            request.setAttribute("leaveTypeJson", new Gson().toJson(leaveType));
             List<Report> substitutionType = ReportDao.getSubstitutionTypePercentage(start, end);
            request.setAttribute("substitutionTypeJson", new Gson().toJson(substitutionType));

        } catch (Exception e) {
            e.printStackTrace();
        }


        // Forward to report.jsp
        RequestDispatcher rd = request.getRequestDispatcher("REPORT.jsp");
        rd.forward(request, response);
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
