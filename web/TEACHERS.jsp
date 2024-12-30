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
        <link rel="stylesheet" href="css/list.css">        
        <title>Manage Teacher</title>
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <div id="section">
            <h1 id="title">Manage Teacher</h1>
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
            <button id="button" type="button" onclick="window.location.href = 'addTeacher.jsp';">Add Teacher</button>
        </div>

    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

</html>
