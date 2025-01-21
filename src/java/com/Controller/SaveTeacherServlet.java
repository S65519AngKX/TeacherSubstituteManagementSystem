/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Model.Teacher;
import com.Dao.TeacherDao;
import com.Dao.UserDao;
import com.Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.Database;
import util.PasswordUtil;

/**
 *
 * @author ACER
 */
@WebServlet(name = "SaveTeacherServlet", urlPatterns = {"/SaveTeacherServlet"})
public class SaveTeacherServlet extends HttpServlet {

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
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contactNo = request.getParameter("contactNo");
        String role = request.getParameter("role");
        String telegramID = request.getParameter("telegramId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // Hash password for security purposes
        String hashedPassword = PasswordUtil.hashPassword(password);

        Teacher teacher = new Teacher();
        teacher.setTeacherName(name);
        teacher.setTeacherEmail(email);
        teacher.setTeacherContact(contactNo);
        teacher.setTeacherRole(role);
        teacher.setTelegramId(telegramID);

        // Get database connection
        try ( Connection conn = Database.getConnection()) {
            conn.setAutoCommit(false); 

            int teacherId = TeacherDao.save(teacher, conn);
            if (teacherId > 0) {
                User user = new User();
                user.setUsername(username);
                user.setPassword(hashedPassword);
                user.setTeacherId(teacherId);

                int userStatus = UserDao.save(user, conn);
                System.out.println("User Status: " + userStatus);

                if (userStatus > 0) {
                    // Commit transaction if both teacher and user save successfully
                    conn.commit();
                    out.print("<script>alert('Record saved successfully!');</script>");
                    request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
                } else {
                    // Rollback if user save fails
                    conn.rollback();
                    out.print("<script>alert('Sorry! Unable to save user record. Please use another username.');</script>");
                    request.getRequestDispatcher("addTeacher.jsp").include(request, response);
                }
            } else {
                // Rollback if teacher save fails
                conn.rollback();
                out.print("<script>alert('Sorry! Unable to save teacher record. Please use another email address');</script>");
                request.getRequestDispatcher("addTeacher.jsp").include(request, response);
            }

            conn.setAutoCommit(true); // Restore default behavior

        } catch (Exception e) {
            e.printStackTrace();
            try {
                out.print("<script>alert('An unexpected error occurred. Please try again later.');</script>");
                request.getRequestDispatcher("addTeacher.jsp").include(request, response);
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        } finally {
            out.close();
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
