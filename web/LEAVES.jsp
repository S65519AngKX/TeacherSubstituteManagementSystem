<%@page import="com.Model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.Model.Leave"%>
<%@page import="com.Dao.LeaveDao"%>
<%@page import="com.Dao.TeacherDao"%>  

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos+Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/list.css">
        <title>Manage Leave</title>
        <style>
            .action-buttons {
                display:flex;
                flex-direction: row;
                gap: 10px;
            }
            .action-buttons button {
                background-color: grey;
                color: white;
                padding: 5px;
                border: none;
                font-size: 13px;
                border-radius: 5px;
                width:70px;
                box-shadow: 2px 2px 2px black;

            }
            .action-buttons button:hover {
                opacity:0.7;
            }
            .delete-icon i{
                color: red;
                font-size:13px;
            }

            .delete-icon i:hover {
                color: darkred;
            }
            #delete{
                text-align: center;
            }

        </style>
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <div id="section">
            <h1 id="title">Manage Leave</h1>
            <table>
                <tr>
                    <th>Leave ID</th>
                    <th>Teacher Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Reason</th>
                    <th>Notes</th>
                    <th>Status</th>
                    <th colspan="2">Action</th>
                </tr>
                <%
                    List<Leave> list = LeaveDao.getAllUnprocessedLeave();
                    for (Leave e : list) {
                        Teacher teacher = TeacherDao.getTeacherById(e.getAbsentTeacherID());
                %>
                <tr>
                    <td><%= e.getLeaveID()%></td>
                    <td><%= teacher != null ? teacher.getTeacherName() : "Not found"%></td>
                    <td><%= e.getLeaveStartDate()%></td>
                    <td><%= e.getLeaveEndDate()%></td>
                    <td><%= e.getLeaveReason()%></td>
                    <td><%= e.getLeaveNotes()%></td>
                    <td><%= e.getLeaveStatus()%></td> 

                    <!-- Action buttons in one column -->
                    <td class="action-buttons">
                        <form action="UpdateLeaveStatusServlet" method="post">
                            <input type="hidden" name="leaveId" value="<%= e.getLeaveID()%>">
                            <input type="hidden" name="status" value="Approved">
                            <button type="submit" style="background-color:#4CAF50">Approve</button>
                        </form>

                        <form action="UpdateLeaveStatusServlet" method="post">
                            <input type="hidden" name="leaveId" value="<%= e.getLeaveID()%>">
                            <input type="hidden" name="status" value="Rejected">
                            <button type="submit" onclick="return confirm('Do you want to reject this leave request?');">Reject</button>
                        </form>
                    </td>
                    <td>
                        <a href="DeleteLeaveServlet?leaveId=<%= e.getLeaveID()%>" 
                           onclick="return confirm('Do you want to delete this leave record?');" 
                           class="delete-icon">
                            <i class="fas fa-trash-alt"></i>
                        </a>

                    </td>
                </tr>
                <%
                    }
                %>
            </table>
            <button id="button" type="button" onclick="window.location.href = 'leaveHistory.jsp';">Leave History</button>
        </div>
    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

</html>
