/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.ScheduleDao;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Dao.SubstitutionDao;
import com.Dao.TeacherDao;
import com.Model.Substitution;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@WebServlet(name = "SubstitutionServlet", urlPatterns = {"/SubstitutionServlet"})
public class SubstitutionServlet extends HttpServlet {

    private SubstitutionDao SubstitutionDao;

    public void init() {
        SubstitutionDao = new SubstitutionDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Action received: " + action); // Debugging output

        try {
            switch (action) {
                case "delete":
                    deleteSubstitution(request, response);
                    break;
                
                default:
                    listSubstitution(request, response);
                    break;
            }
        } catch (SQLException | IOException | ServletException ex) {
            ex.printStackTrace();
        }

    }

    private void listSubstitution(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("substitutionHistory.jsp");
        dispatcher.forward(request, response);
    }
    private void deleteSubstitution(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();

        try {
            int substitutionId = Integer.parseInt(request.getParameter("substitutionId"));
            int status = SubstitutionDao.delete(substitutionId);
            if (status > 0) {
                response.getWriter().print("<script>alert('Substitution record deleted successfully!');</script>");
                request.getRequestDispatcher("substitutionHistory.jsp").include(request, response);
            } else {
                response.getWriter().print("<script>alert('Sorry! Unable to delete substitution record.');</script>");
                request.getRequestDispatcher("substitutionHistory.jsp").include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("<script>alert('An error occurred while deleting the record. Please try again!'); window.location.href='substitutionHistory.jsp';</script>");
        }
    }
}
