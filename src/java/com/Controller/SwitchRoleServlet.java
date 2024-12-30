package com.Controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(name = "SwitchRoleServlet", urlPatterns = {"/SwitchRoleServlet"})
public class SwitchRoleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Avoid creating a new session if one doesn't exist
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String currentRole = (String) session.getAttribute("role");

        if ("Principal".equals(currentRole) || "Assistant Principal".equals(currentRole)) {
            session.setAttribute("tempRole", "Teacher");
            response.sendRedirect("HOME.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You are not authorized to switch roles.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); 
    }

}
