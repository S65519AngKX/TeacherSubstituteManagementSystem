/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.TeacherDao;
import com.Dao.UserDao;
import com.Model.Teacher;
import com.Model.User;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.PasswordUtil;

/**
 *
 * @author ACER
 */
@WebServlet(name = "manageProfile", urlPatterns = {"/manageProfile"})
public class manageProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(password);
        String email = request.getParameter("email");
        String contactNo = request.getParameter("contact");
        String role = request.getParameter("role");
        String id = request.getParameter("teacherId");

        Teacher teacher = new Teacher();
        teacher.setTeacherName(name);
        teacher.setTeacherEmail(email);
        teacher.setTeacherContact(contactNo);
        teacher.setTeacherRole(role);
        teacher.setTeacherID(Integer.parseInt(id));

        User user = new User();
        user.setUsername(username);
        if (!password.isEmpty()) {
            user.setPassword(hashedPassword);
        }
        user.setTeacherId(Integer.parseInt(id));

        int status = TeacherDao.update(teacher);
        int status2 = UserDao.update(user);

        if (status > 0 && status2 > 0) {
            out.print("<script>alert('Record updated successfully!');</script>");
            request.getRequestDispatcher("HOME.jsp").include(request, response);
        } else {
            out.print("<script>alert('Sorry! Unable to update record.');</script>");
            request.getRequestDispatcher("HOME.jsp").include(request, response);
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
