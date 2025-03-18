/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.Controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.UUID;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.Database;

@WebServlet(name = "SendResetLinkServlet", urlPatterns = {"/SendResetLinkServlet"})
public class SendResetLinkServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                long expirationTime = System.currentTimeMillis() + (60 * 60 * 1000); // Token valid for 1 hour
                Timestamp expirationTimestamp = new Timestamp(expirationTime);  
                PreparedStatement updatePs = con.prepareStatement("UPDATE user INNER JOIN teacher ON user.teacherId = teacher.teacherId SET token=?, token_expiry=? WHERE teacher.teacherEmail=?");
                updatePs.setString(1, token);
                updatePs.setTimestamp(2, expirationTimestamp); 
                updatePs.setString(3, email);
                updatePs.executeUpdate();

                // Send email
                sendEmail(email, token);
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

    private void sendEmail(String recipient, String token) throws MessagingException, UnsupportedEncodingException {
        String subject = "SmartSub Password Reset Request";
        String resetLink = "http://localhost:8080/S65519_TeacherSubstituteManagementSystem/resetPasswordForm.jsp?token=" + token;

        String message = "<p>Dear user, please kindly click the link below to reset your password:</p>"
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

