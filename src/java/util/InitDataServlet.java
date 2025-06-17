/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package util;

import util.PasswordUtil;
import util.Database;
import com.Dao.UserDao;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author fakhr
 */
// to be ran before login http://localhost:8080/setup/init-data?token=secret123
public class InitDataServlet extends HttpServlet {

    private static final String INIT_TOKEN = "secret123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (!INIT_TOKEN.equals(token)) {
            response.setStatus(403);
            response.setContentType("text/plain");
            response.getWriter().println("Access denied. Invalid token.");
            return;
        }

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head>");
        out.println("<meta http-equiv='refresh' content='3;URL=" + request.getContextPath() + "/login'>");
        out.println("<title>Initializing...</title></head><body>");
        out.println("<h3>Initializing system data...</h3><pre>");

        try ( Connection conn = Database.getConnection()) {
            UserDao userDAO = new UserDao();

            String[] usernames = {
                "alexlee", "chinghuey", "chinsu", "hooimin", "jiayi", "kuehcc", "leanlee",
                "liyana", "pingsiew", "qinxiao", "sarah", "shenzhon", "yeleok", "yinbee", "yinmei"
            };

            // Update each password to username + "123"
            for (String username : usernames) {
                String newPassword = username + "123";
                updatePassword(out, conn, userDAO, username, newPassword);
            }

            out.println("</pre><p>Passwords updated. Redirecting to login in 3 seconds...</p>");
        } catch (Exception e) {
            out.println("</pre><p style='color:red;'>Failed to update passwords:</p><pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }

        out.println("</body></html>");
    }

    private void updatePassword(PrintWriter out, Connection conn, UserDao userDAO, String username, String newPlainPassword) {
        try {
            String hashedPassword = PasswordUtil.hashPassword(newPlainPassword);
            PreparedStatement ps = conn.prepareStatement("UPDATE users SET password = ? WHERE username = ?");
            ps.setString(1, hashedPassword);
            ps.setString(2, username);
            int affected = ps.executeUpdate();

            if (affected > 0) {
                out.println("Password updated for: " + username);
            } else {
                out.println("User not found: " + username);
            }
        } catch (Exception e) {
            out.println("Error updating: " + username);
            e.printStackTrace(out);
        }
    }
}
