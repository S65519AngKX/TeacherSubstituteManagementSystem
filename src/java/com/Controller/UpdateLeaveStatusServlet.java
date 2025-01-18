package com.Controller;

import com.Dao.LeaveDao;
import com.Model.Leave;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.OutputStream;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateLeaveStatusServlet", urlPatterns = {"/UpdateLeaveStatusServlet"})
public class UpdateLeaveStatusServlet extends HttpServlet {

    // Telegram Bot settings
    private static final String TELEGRAM_BOT_TOKEN = "7875648625:AAHuc62etZLbotxvdUwvfKT9qCH1fBfGfk8";
    String CHAT_ID = null;  // Chat ID for the teacher(teacher need to get their user id first usinf the IDBOT from telegram)

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int leaveId = Integer.parseInt(request.getParameter("leaveId"));
        String status = request.getParameter("status");
        Leave leave = LeaveDao.getLeaveDetailsByLeaveID(leaveId);
        int result = LeaveDao.updateLeaveStatus(leaveId, status);

        if (result > 0) {
            sendTelegramNotification(leave, status);  // Send notification to telegram
            response.sendRedirect("LEAVES.jsp");
        } else {
            // Error handling if unable to approve/reject
            response.getWriter().print("<script>alert('Unable to approve/reject the leave request.');</script>");
            response.sendRedirect("LEAVES.jsp");
        }
    }

    // send Telegram notification method
    private void sendTelegramNotification(Leave leave, String status) {
        try {
            CHAT_ID = leave.getTelegramId();
            String message = "Dear " + leave.getTeacherName() + ",\n\nYour leave request (Leave ID: " + leave.getLeaveID()
                    + ") from " + leave.getLeaveStartDate() + " to " + leave.getLeaveEndDate() + " has been " + status + ".\n\nBest regards,\nPrincipal";

            // URL-encode the message to ensure no illegal characters
            String encodedMessage = URLEncoder.encode(message, "UTF-8");

            // Construct the Telegram URL
            String urlString = "https://api.telegram.org/bot" + TELEGRAM_BOT_TOKEN + "/sendMessage?chat_id=" + CHAT_ID + "&text=" + encodedMessage;
            System.out.println("URL: " + urlString); // This will show the full URL in the console

            // Create a URL object and open a connection
            URL url = new URL(urlString);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Set request method and headers
            connection.setRequestMethod("GET");
            connection.setDoOutput(true);

            // Send the request
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Success
                System.out.println("Telegram notification sent successfully.");
            } else {
                // Handle error response
                System.out.println("Failed to send Telegram notification. Response code: " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error sending Telegram notification: " + e.getMessage());
        }
    }
}
