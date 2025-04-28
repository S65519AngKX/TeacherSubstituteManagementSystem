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
        <title>Leave History</title>
        <style>
            table tr td,th{
                text-align:  center;
            }

        </style>
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <div id="section">
            <ul class="breadcrumb">
                <li><a href="HOME.jsp">Home</a></li>
                <li><a href="LEAVE.jsp">Leave</a></li>
                <li>Leave History</li>
            </ul>
            <h1 id="title">Leave History</h1>
            <table>
                <tr>
                    <th>Leave ID</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Reason</th>
                    <th>Notes</th>
                    <th>Status</th>
                </tr>
                <%
                    String teacherIdStr = (String) session.getAttribute("teacherId");
                    List<Leave> list = LeaveDao.getLeaveByTeacherId(Integer.parseInt(teacherIdStr));
                    for (Leave e : list) {
                %>
                <tr>
                    <td><%= e.getLeaveID()%></td>
                    <td><%= e.getLeaveStartDate()%></td>
                    <td><%= e.getLeaveEndDate()%></td>
                    <td><%= e.getLeaveReason()%></td>
                    <td><%= e.getLeaveNotes()%></td>
                    <td><%= e.getLeaveStatus()%></td> 
                </tr>
                <%
                    }
                %>
            </table>
            <button id="button" type="button" onclick="window.location.href = 'LEAVE.jsp';">BACK</button>
        </div>
    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

</html>
