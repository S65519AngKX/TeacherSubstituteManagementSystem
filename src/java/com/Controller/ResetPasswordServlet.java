package com.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPasswordServlet"})
public class ResetPasswordServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(ResetPasswordServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");

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
                    updatePs.setString(1, newPassword);
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
}
