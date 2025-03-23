/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Dao.TeacherDao;
import com.Dao.UserDao;
import com.Model.Teacher;
import com.Model.User;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.http.HttpSession;
import util.Database;
import util.PasswordUtil;

@WebServlet(name = "TeacherServlet", urlPatterns = {"/TeacherServlet"})
public class TeacherServlet extends HttpServlet {

    private TeacherDao teacherDao;

    public void init() {
        teacherDao = new TeacherDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "save":
                    saveTeacher(request, response);
                    break;
                case "delete":
                    deleteTeacher(request, response);
                    break;
                case "update":
                    updateTeacher(request, response);
                    break;
                case "manageProfile":
                    manageProfile(request, response);
                    break;
                case "exitRole":
                    exitRole(request, response);
                    break;
                case "switchRole":
                    switchROle(request, response);
                    break;
                default:
                    manageProfileForm(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void manageProfileForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        response.sendRedirect("manageProfile.jsp");
    }

    //wrong
    private void saveTeacher(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
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
                response.sendRedirect("addTeacher.jsp");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        } finally {
            out.close();
        }
    }

    private void updateTeacher(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contactNo = request.getParameter("contactNo");
        String role = request.getParameter("role");
        String telegramID = request.getParameter("telegramId");
        String id = request.getParameter("teacherId");

        Teacher teacher = new Teacher();
        teacher.setTeacherName(name);
        teacher.setTeacherEmail(email);
        teacher.setTeacherContact(contactNo);
        teacher.setTeacherRole(role);
        teacher.setTelegramId(telegramID);
        teacher.setTeacherID(Integer.parseInt(id));

        int status = TeacherDao.update(teacher);
        if (status > 0) {
            out.print("<script>alert('Record updated successfully!');</script>");
            request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
        } else {
            out.print("<script>alert('Sorry! Unable to update record.');</script>");
            request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
        }
        out.close();
    }

    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
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
                response.getWriter().print("<script>alert('Teacher and user record deleted successfully!');</script>");
                request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
            } else {
                response.getWriter().print("<script>alert('Sorry! Unable to delete teacher record.');</script>");
                request.getRequestDispatcher("TEACHERS.jsp").include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("<script>alert('An error occurred while deleting records.');</script>");
            response.sendRedirect("TEACHERS.jsp");
        }
    }

    private void manageProfile(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(password);
        String email = request.getParameter("email");
        String contactNo = request.getParameter("contact");
        String role = request.getParameter("role");
        String telegramID = request.getParameter("telegramId");
        String id = request.getParameter("teacherId");

        Teacher teacher = new Teacher();
        teacher.setTeacherName(name);
        teacher.setTeacherEmail(email);
        teacher.setTeacherContact(contactNo);
        teacher.setTeacherRole(role);
        teacher.setTelegramId(telegramID);
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

    private void exitRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().removeAttribute("tempRole");
        response.sendRedirect("HOME.jsp");
    }

    private void switchROle(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
}
