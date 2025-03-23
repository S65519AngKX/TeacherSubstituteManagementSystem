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
                    <th>Telegram ID</th>
                    <th>Action</th>
                </tr>
                <%
                    List<Teacher> list = TeacherDao.getAllTeacher();
                    for (Teacher e : list) {
                %>
                <tr class="editable-row reservation-row" data-reservation-id="<%= e.getTeacherID()%>" data-teacher-id="<%= e.getTeacherID()%>">
                    <td><%= e.getTeacherID()%></td>
                    <td><%= e.getTeacherName()%></td>
                    <td><%= e.getTeacherEmail()%></td>
                    <td><%= e.getTeacherContact()%></td>
                    <td><%= e.getTeacherRole()%></td>
                    <td><%= e.getTelegramId()%></td>
                    <td>
                        <a href="<%= request.getContextPath()%>/TeacherServlet?action=delete&teacherId=<%= e.getTeacherID()%>" 
                           onclick="return confirm('Do you want to delete this teacher?');" 
                           class="delete-icon">
                            <i class="fas fa-trash-alt"></i>
                        </a>
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
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.editable-row').forEach(function (row) {
                row.addEventListener('click', function () {
                    if (event.target.closest('.delete-icon')) {
                        return;
                    }
                    var teacher = row.getAttribute('data-teacher-id');
                    window.location.href = 'editTeacher.jsp?teacherId=' + teacher;
                });
            });
        });
    </script>
</html>
