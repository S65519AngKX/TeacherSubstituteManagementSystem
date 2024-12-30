package com.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.Dao.LeaveDao;

@WebServlet(name = "UpdateLeaveStatusServlet", urlPatterns = {"/UpdateLeaveStatusServlet"})
public class UpdateLeaveStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve leaveId and status from the request
        int leaveId = Integer.parseInt(request.getParameter("leaveId"));
        String status = request.getParameter("status");

        int result = LeaveDao.updateLeaveStatus(leaveId, status);

        if (result > 0) {
            response.sendRedirect("LEAVES.jsp");
        } else {
            response.getWriter().print("<script>alert('Unable to approve/reject the leave request.');</script>");
            response.sendRedirect("LEAVES.jsp");
            return;
        }
    }
}
