/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.PasswordUtil;

/**
 *
 * @author Khe Xin
 */
public class LoginServlet extends HttpServlet {

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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/substitutemanagement", "root", "admin");

            PreparedStatement staffPS = con.prepareStatement("SELECT * FROM user WHERE username=?");
            staffPS.setString(1, username);
            ResultSet teacherRS = staffPS.executeQuery();

            if (teacherRS.next()) {
                String storedHashedPassword = teacherRS.getString("password");
                if (PasswordUtil.checkPassword(password, storedHashedPassword)) {
                    String teacherId = teacherRS.getString("teacherId");

                    PreparedStatement teacherPS = con.prepareStatement("SELECT * FROM teacher WHERE teacherId=?");
                    teacherPS.setString(1, teacherId);
                    ResultSet nameRS = teacherPS.executeQuery();

                    if (nameRS.next()) {
                        String teacherName = nameRS.getString("teacherName");
                        String teacherEmail = nameRS.getString("teacherEmail");
                        String teacherContact = nameRS.getString("teacherContact");
                        String teacherRole = nameRS.getString("teacherRole");
                        session.setAttribute("teacherId", teacherId);
                        session.setAttribute("name", teacherName);
                        session.setAttribute("email", teacherEmail);
                        session.setAttribute("contact", teacherContact);
                        session.setAttribute("role", teacherRole);
                        session.setAttribute("username", username);
                        session.setAttribute("password", password);

                        response.sendRedirect("HOME.jsp");
                    } else {
                        out.println("<script>alert('Teacher name not found.'); window.location.href='index.jsp';</script>");
                    }
                } else {
                    out.println("<script>alert('Invalid username or password.'); window.location.href='index.jsp';</script>");
                }
            } else {
                out.println("<script>alert('Invalid username or password.'); window.location.href='index.jsp';</script>");
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred.'); window.location.href='index.jsp';</script>");
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
