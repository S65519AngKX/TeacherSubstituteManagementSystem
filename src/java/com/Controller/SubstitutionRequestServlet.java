/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.SubstitutionAssignmentDao;
import com.Dao.SubstitutionDao;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Dao.SubstitutionRequestDao;
import com.Dao.SubstitutionRequestPeriodDao;
import com.Model.Substitution;
import com.Model.SubstitutionRequest;
import com.Model.SubstitutionRequestPeriod;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import util.Database;

@WebServlet("/")
public class SubstitutionRequestServlet extends HttpServlet {

    private SubstitutionRequestDao SubstitutionRequestDao;

    public void init() {
        SubstitutionRequestDao = new SubstitutionRequestDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/saveSubstitutionRequest":
                    saveSubstitutionRequest(request, response);
                    break;
                default:
                    showSubstitutionRequestForm(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void showSubstitutionRequestForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        response.sendRedirect("requestSubstitution.jsp");
    }

    private void saveSubstitutionRequest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();
        int requestTeacherId = Integer.parseInt(request.getParameter("requestTeacherId"));
        Date substitutionRequestDate = java.sql.Date.valueOf(request.getParameter("substitutionRequestDate"));
        String substitutionRequestReason = request.getParameter("substitutionRequestReason");
        String substitutionRequestNotes = request.getParameter("substitutionRequestNotes");
        String[] selectedPeriods = request.getParameterValues("substitutionRequestPeriod");

        // Validate period selection
        if (selectedPeriods == null || selectedPeriods.length == 0) {
            out.print("<script>alert('Please select at least one period!'); window.location.href='requestSubstitution.jsp';</script>");
            return;
        }

        SubstitutionRequest newReq = new SubstitutionRequest(requestTeacherId, substitutionRequestDate, substitutionRequestReason, substitutionRequestNotes);

        try ( Connection conn = Database.getConnection()) {
            conn.setAutoCommit(false);
            int substitutionRequestId = SubstitutionRequestDao.save(newReq, conn);

            if (substitutionRequestId > 0) {
                boolean allPeriodsSaved = true;

                // Insert each selected period as a separate row
                for (String period : selectedPeriods) {
                    SubstitutionRequestPeriod requestPeriod = new SubstitutionRequestPeriod();
                    requestPeriod.setSubstitutionRequestId(substitutionRequestId);
                    requestPeriod.setSubstitutionRequestPeriod(Integer.parseInt(period));

                    int periodStatus = SubstitutionRequestPeriodDao.save(requestPeriod, conn);
                    if (periodStatus <= 0) {
                        allPeriodsSaved = false;
                        break;
                    }
                }

                if (allPeriodsSaved) {
                    Substitution substitution = new Substitution();
                    substitution.setSubstitutionDate(substitutionRequestDate);
                    substitution.setSubstitutionRequestId(substitutionRequestId);

                    int substitutionId = SubstitutionDao.save(substitution, conn);
                    if (substitutionId < 0) {
                        conn.rollback();
                        out.print("<script>alert('Failed to save substitution details. Please try again!'); window.location.href='requestSubstitution.jsp';</script>");
                    } else {
                        SubstitutionAssignmentDao.createSubstitutionAssignmentsForSubstitutionRequest(substitutionRequestId, requestTeacherId, substitutionRequestDate, substitutionId, conn);
                        conn.commit();
                        out.print("<script>alert('Substitution Request made successfully!'); window.location.href='substitutionRequestHistory.jsp';</script>");
                    }
                } else {
                    conn.rollback();
                    out.print("<script>alert('Failed to save substitution request periods. Please try again!'); window.location.href='requestSubstitution.jsp';</script>");
                }
            } else {
                conn.rollback();
                out.print("<script>alert('Sorry! Unable to save substitution request.'); window.location.href='requestSubstitution.jsp';</script>");
            }

            conn.setAutoCommit(true); // Restore default behavior
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* private void deleteSubstitutionRequest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("substitutionRequestId"));
        int status = SubstitutionRequestDao.delete(id);
        if (status > 0) {
            response.getWriter().print("<script>alert('Substitution request record deleted successfully!');</script>");
            request.getRequestDispatcher("substitutionRequestHistory.jsp").include(request, response);
        } else {
            response.getWriter().print("<script>alert('Sorry! Unable to delete substitutionRequest record.');</script>");
            request.getRequestDispatcher("substitutionRequestHistory.jsp").include(request, response);
        }
    } */
}
