<%@page import="com.Model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.Model.Leave"%>
<%@page import="com.Dao.LeaveDao"%>
<%@page import="com.Dao.TeacherDao"%>  
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

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
        <title>Leave Approval/Rejection</title>
        <style>
            #top{
                display: flex;
                align-items: center;
            }
            #title{
                font-size: 30px;
                margin:10px auto;
                margin-left: 38%;
            }
            #button{
                border: 0;
                border-radius: 10px;
                padding: 5px 20px;
                font-size: 13px;
                width: fit-content;
                height: fit-content;
                box-shadow: 2px 2px 2px black;
                text-align: center;
                margin: 10px auto 0px auto;
                margin-right: 3%;
            }
            .action-buttons {
                display:flex;
                justify-content: space-between;
                align-items: center;
                margin:0 10%;
            }
            .action-buttons button {
                background-color: grey;
                color: white;
                font-weight: bold;
                padding: 5px 15px;
                border: none;
                font-size: 13px;
                border-radius: 5px;
                width:fit-content;
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

            @media screen and (max-width: 767px) {
                #button{
                    padding:5px;
                    font-size:12px;
                    margin-bottom: 10px;
                    width:20%;
                }
                .action-buttons button{
                    font-size:12px;
                    width:50px;
                }
            }

        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <div id="section">
            <div id='top'>
                <h1 id="title">Leave Approval/Rejection</h1>
                <button id="button" type="button" onclick="window.location.href = 'leaveHistory.jsp';">Leave History</button>
            </div>
            <table>
                <tr>
                    <th>Leave ID</th>
                    <th>Teacher Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Reason</th>
                    <th>Notes</th>
                    <th>Status</th>
                </tr>
                <%
                    List<Leave> list = LeaveDao.getAllUnprocessedLeave();
                    LocalDate today = LocalDate.now(); // Get today's date
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

                    for (Leave e : list) {
                        Teacher teacher = TeacherDao.getTeacherById(e.getAbsentTeacherID());
                        LocalDate startDate = LocalDate.parse(e.getLeaveStartDate().toString(), formatter);
                        LocalDate endDate = LocalDate.parse(e.getLeaveEndDate().toString(), formatter);
                        boolean isCurrentLeave = !today.isBefore(startDate) && !today.isAfter(endDate);
                %>
                <tr <% if (isCurrentLeave) { %> style="background-color:#db9b97;" <% }%> >
                    <td><%= e.getLeaveID()%></td>
                    <td><%= teacher != null ? teacher.getTeacherName() : "Not found"%></td>
                    <td><%= e.getLeaveStartDate()%></td>
                    <td><%= e.getLeaveEndDate()%></td>
                    <td><%= e.getLeaveReason()%></td>
                    <td><%= e.getLeaveNotes()%></td>

                    <!-- Action buttons in one column -->
                    <td class="action-buttons">
                        <form action="LeaveServlet" method="post">
                            <input type="hidden" name="leaveId" value="<%= e.getLeaveID()%>">
                            <input type="hidden" name="leaveStatus" value="Approved">
                            <button type="submit" style="background-color:#4CAF50" name="action" value="update">Approve</button>
                        </form>

                        <form action="LeaveServlet" method="post">
                            <input type="hidden" name="leaveId" value="<%= e.getLeaveID()%>">
                            <input type="hidden" name="leaveStatus" value="Rejected">
                            <button type="submit" name="action" value="update" onclick="return confirm('Do you want to reject this leave request?');">Reject</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>



</html>
