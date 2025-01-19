/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.TeacherDao;
import com.Dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
@WebServlet(name = "DeleteTeacherServlet", urlPatterns = {"/DeleteTeacherServlet"})
public class DeleteTeacherServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String teacherIdStr = request.getParameter("teacherId");

        int teacherId = Integer.parseInt(teacherIdStr);
        String username = UserDao.getUsernameByTeacherId(teacherId);
        if (username == null || username.isEmpty()) {
            response.getWriter().print("<script>alert('No corresponding user found for the teacher.');</script>");
            response.sendRedirect("TEACHERS.jsp");
            return;
        }

        try {
            int teacherStatus = TeacherDao.delete(teacherId);
            if (teacherStatus > 0) {
                int userStatus = UserDao.delete(username);
                if (userStatus > 0) {
                    response.getWriter().print("<script>alert('Teacher and user record deleted successfully!');</script>");
                    request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
                } else {
                    response.getWriter().print("<script>alert('Sorry! Unable to delete user record.');</script>");
                    request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
                }
            } else {
                response.getWriter().print("<script>alert('Sorry! Unable to delete teacher record.');</script>");
                request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("<script>alert('An error occurred while deleting records.');</script>");
            request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
        }
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
