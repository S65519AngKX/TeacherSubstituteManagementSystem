/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Model.Teacher;
import com.Dao.TeacherDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
@WebServlet(name = "EditTeacherServlet2", urlPatterns = {"/EditTeacherServlet2"})
public class EditTeacherServlet2 extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String teacherId = request.getParameter("teacherId");
        int id = Integer.parseInt(teacherId);
        Teacher e = TeacherDao.getTeacherById(id);

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Stardos Stencil'>");
        out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>");
        out.println("<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css'>");
        out.println("<link rel='stylesheet' href='css/style.css'>");
        out.println("<link rel='stylesheet' href='css/form.css'>");
        out.println("<title>Update Teacher</title>");
        out.println("</head>");
        out.println("<header>");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/header.jsp");
        dispatcher.include(request, response);
        out.println("</header>");
        out.println("<body>");
        out.println("<h1 id='title'>Update Teacher</h1>");
        out.println("<form method='post' action='EditTeacherServlet'>");
        out.println("<table>");
        out.println("<tr>");
        out.println("<td><label>Teacher ID: </label></td>");
        out.println("<td><input type='text' name='teacherId' value='" + e.getTeacherID() + "' readonly></td>");
        out.println("</tr>");
        out.println("<tr>");
        out.println("<td><label for='name'>Name: </label></td>");
        out.println("<td><input type='text' name='name' maxlength='50' value='" + e.getTeacherName() + "' required></td>");
        out.println("</tr>");
        out.println("<tr>");
        out.println("<td><label for='email'>Email: </label></td>");
        out.println("<td><input type='text' name='email' maxlength='50' value='" + e.getTeacherEmail() + "' required></td>");
        out.println("</tr>");
        out.println("<tr>");
        out.println("<td><label for='contactNo'>Contact No:</label></td>");
        out.println("<td><input type='text' name='contactNo' maxlength='15' value='" + e.getTeacherContact() + "' pattern=\"01[0-9]-[0-9]{7,8}\" required></td>");
        out.println("</tr>");
        out.println("<tr>");
        out.println("<td><label for='role'>Role: </label></td>");
        out.println("<td><select name='role' value=" + e.getTeacherRole() + "required>");
        if ("Teacher".equals(e.getTeacherRole())) {
            out.println("<option value='Teacher' selected>Teacher</option>");
            out.println("<option value='Principal'>Principal</option>");
            out.println("<option value='Assistant Principal'>Assistant Principal</option>");
        } else if ("Principal".equals(e.getTeacherRole())) {
            out.println("<option value='Teacher'>Teacher</option>");
            out.println("<option value='Principal' selected>Principal</option>");
            out.println("<option value='Assistant Principal'>Assistant Principal</option>");
        } else {
            out.println("<option value='Teacher'>Teacher</option>");
            out.println("<option value='Principal'>Principal</option>");
            out.println("<option value='Assistant Principal'selected>Assistant Principal</option>");
        }
        out.println("</select></td>");
        out.println("</tr>");
        out.println("<tr>");
        out.println("<td><label for='telegramId'>Chat ID(Telegram): </label></td>");
        out.println("<td><input type='text' name='telegramId' maxlength='10' value='" + e.getTelegramId()+ "'pattern=\"[0-9]{10}\" ></td>");
        out.println("</tr>");
        out.println("</table>");
        out.println("<br><br>");
        out.println("<div id='formButton'>");
        out.println("<input type='submit' value='Update'>");
        out.println("<input style='background-color: #9da0a1' type='reset' value='Cancel' onclick=\"window.location.href='TEACHERS.jsp'\">");
        out.println("</div>");
        out.println("</form>");
        out.println("</body>");
        out.println("<footer>");
        RequestDispatcher dispatcher2 = request.getRequestDispatcher("/footer.jsp");
        dispatcher2.include(request, response);
        out.println("</footer>");
        out.println("</html>");

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
