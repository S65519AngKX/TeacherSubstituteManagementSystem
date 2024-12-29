<%-- 
    Document   : manageStaff
    Created on : May 22, 2024, 12:44:29 AM
    Author     : ACER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.Model.Teacher"%>
<%@page import="com.Dao.TeacherDao"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos+Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Manage Teacher</title>
        <style>
            #manageTeacher {
                text-align: center;
                font-size: 40px;
                margin: 20px;
                text-shadow:
                    2.5px 2.5px 0px #1fb1c4,
                    5px 5px 2px rgba(255, 255, 255);
            }
            table {
                width: 95%;
                border-collapse: collapse;
                margin: 20px auto;
            }
            table, th, td {
                border: 1.5px solid #1fb1c4;
            }
            th, td {
                padding: 10px;
                text-align: left;
                font-size: 15px;
            }
            th {
                background-color: #1fb1c4;
                text-align: center;
                font-size: 15px;
            }
            tr:nth-child(even) {
                background-color: #acebf2;
            }
            tr:nth-child(even) {
                background-color: #c8f4f7;
            }
            tr:hover {
                background-color: #ddd;
            }
            #add{
                background-color: #1fbfdb;
                color:white;
                border: 0px;
                border-radius:10px;
                padding:8px 5px;
                font-size:15px;
                margin-bottom: 20px;
                width:10%;
                float: right;
                margin-right:2.5%;
            }
            #add:hover{
                opacity:0.8;
            }
            #section{
                margin-bottom: 30px;
            }

        </style>
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <div id="section">
            <h1 id="manageTeacher">Manage Teacher</h1>
            <table>
                <tr>
                    <th>Teacher ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact No</th>
                    <th>Role</th>
                    <th colspan="2">Action</th>
                </tr>
                <%
                    List<Teacher> list = TeacherDao.getAllTeacher();
                    for (Teacher e : list) {
                %>
                <tr>
                    <td><%= e.getTeacherID()%></td>
                    <td><%= e.getTeacherName()%></td>
                    <td><%= e.getTeacherEmail()%></td>
                    <td><%= e.getTeacherContact()%></td>
                    <td><%= e.getTeacherRole()%></td>
                    <td><a href="EditTeacherServlet2?teacherId=<%= e.getTeacherID()%>">Edit</a></td>
                    <td><a href="DeleteTeacherServlet?teacherId=<%= e.getTeacherID()%>" onclick="return confirm('Do you want to delete this teacher?');">Delete</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
            <button id="add" type="button" onclick="window.location.href = 'addTeacher.jsp';">Add Teacher</button>
        </div>

    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

</html>
