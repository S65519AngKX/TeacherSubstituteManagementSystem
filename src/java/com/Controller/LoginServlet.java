/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import com.Dao.TeacherDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.Database;
import util.PasswordUtil;

/**
 *
 * @author Khe Xin
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private TeacherDao teacherDao;
    private static final Logger logger = Logger.getLogger(LoginServlet.class.getName());

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
                case "login":
                    loginAccount(request, response);
                    break;
                case "reset":
                    resetPassword(request, response);
                    break;
                case "getLink":
                    getResetLink(request, response);
                    break;
                default:
                    showLoginForm(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void showLoginForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        response.sendRedirect("index.jsp");
    }

    protected void loginAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

    private void getResetLink(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String email = request.getParameter("email");

        try {
            // Database connection
            Connection con = Database.getConnection();

            // Check if email exists
            PreparedStatement ps = con.prepareStatement("SELECT * FROM user INNER JOIN teacher ON user.teacherId = teacher.teacherId WHERE teacher.teacherEmail=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Generate reset token and save in the database
                String token = UUID.randomUUID().toString();
                String username=rs.getString("username");
                long expirationTime = System.currentTimeMillis() + (60 * 60 * 1000); // Token valid for 1 hour
                Timestamp expirationTimestamp = new Timestamp(expirationTime);
                PreparedStatement updatePs = con.prepareStatement("UPDATE user INNER JOIN teacher ON user.teacherId = teacher.teacherId SET token=?, token_expiry=? WHERE teacher.teacherEmail=?");
                updatePs.setString(1, token);
                updatePs.setTimestamp(2, expirationTimestamp);
                updatePs.setString(3, email);
                updatePs.executeUpdate();

                // Send email
                sendEmail(email, username, token);
                response.getWriter().print("<script>alert('A reset link has been sent to your email.');</script>");
                request.getRequestDispatcher("index.jsp").include(request, response);
            } else {
                response.getWriter().print("<script>alert('Email not found.');</script>");
                request.getRequestDispatcher("resetPassword.jsp").include(request, response);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");
        // Hash the password
        String hashedPassword = PasswordUtil.hashPassword(newPassword);

        logger.info("Received token: " + token);
        logger.info("New password: " + newPassword);

        try {
            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/substitutemanagement", "root", "admin");

            // Fetch token from the database
            PreparedStatement ps = con.prepareStatement("SELECT * FROM user INNER JOIN teacher ON user.teacherId = teacher.teacherId WHERE user.token=?");
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbToken = rs.getString("token");
                logger.info("Database token: " + dbToken);

                Timestamp expiration = rs.getTimestamp("token_expiry");
                logger.info("Token expiration time: " + expiration);

                // Check if token is expired
                if (System.currentTimeMillis() > expiration.getTime()) {
                    response.getWriter().print("<script>alert('The reset link has expired. Please request a new one.');</script>");
                    request.getRequestDispatcher("resetPassword.jsp").include(request, response);
                } else {
                    // Token is valid, proceed to update the password
                    PreparedStatement updatePs = con.prepareStatement("UPDATE user INNER JOIN teacher ON user.teacherId = teacher.teacherId SET user.password=? WHERE user.token=?");
                    updatePs.setString(1, hashedPassword);
                    updatePs.setString(2, token);
                    updatePs.executeUpdate();

                    // Clear the token after password reset
                    PreparedStatement clearTokenPs = con.prepareStatement("UPDATE user INNER JOIN teacher ON user.teacherId = teacher.teacherId SET user.token=NULL, user.token_expiry=NULL WHERE user.token=?");
                    clearTokenPs.setString(1, token);
                    clearTokenPs.executeUpdate();

                    response.getWriter().print("<script>alert('Your password has been successfully reset.');</script>");
                    request.getRequestDispatcher("index.jsp").include(request, response);
                }
            } else {
                response.getWriter().print("<script>alert('Invalid or expired token.');</script>");
                request.getRequestDispatcher("resetPassword.jsp").include(request, response);
            }

            con.close();
        } catch (Exception e) {
            logger.severe("Error during password reset: " + e.getMessage());
            response.getWriter().print("<script>alert('An error occurred while resetting the password. Please try again later.');</script>");
            request.getRequestDispatcher("resetPassword.jsp").include(request, response);
        }
    }

    //other method
    private void sendEmail(String recipient, String username, String token) throws MessagingException, UnsupportedEncodingException {
        String subject = "SmartSub Password Reset Request";
        String resetLink = "http://localhost:8080/S65519_TeacherSubstituteManagementSystem/resetPasswordForm.jsp?token=" + token;

        String message = "<p>Dear user, please kindly click the link below to reset your password:</p>"
                + "<p>Username :"+username+"</p>"
                + "<a href='" + resetLink + "'>Reset Password</a>";

        // Configure mail server settings
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Set up authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("angkhexin@gmail.com", "dtsn yzrd amzi udfx");
            }
        }); //getPasswordAuthentication() function in PasswordAuthentification class in JavaMail API

        // Send email
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress("angkhexin@gmail.com", "SmartSub Support"));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
        msg.setSubject(subject);
        msg.setContent(message, "text/html");
        Transport.send(msg);
    }
}
