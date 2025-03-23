<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.Model.Teacher"%>
<%@ page import="com.Dao.TeacherDao"%>
<%@ page import="com.Model.User"%>
<%@ page import="com.Dao.UserDao"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/form.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Manage Profile</title>
        <style>
            @media only screen and (max-width: 769px){
                #section{
                    flex-grow: 1;
                    overflow: auto;
                }
            }
        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>
        <%
            int id = Integer.parseInt((String) session.getAttribute("teacherId"));
            Teacher teacher = TeacherDao.getTeacherById(id);
            User user = UserDao.getUserByTeacherId(id);
        %>

        <div id="section" class="container h-70"> 
            <div class="row justify-content-center align-items-center">
                <div class="col-12 col-lg-8 col-xl-9">
                    <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                        <div class="card-body p-2 p-md-3">
                            <h3 class="pt-3 pb-md-0 mb-md-1" id="title">Manage Profile</h3>
                            <form method="post" action="TeacherServlet">
                                <div class="form-section">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <input type="hidden" name="teacherId" value="<%= session.getAttribute("teacherId")%>">
                                            <input type="hidden" name="role" value="<%= teacher.getTeacherRole()%>">
                                        </div>
                                    </div>
                                    <div class="row mb-2">
                                        <div class="col-md-6">
                                            <label for="name" class="form-label">Name:</label>
                                            <input type="text" name="name" class="form-control" maxlength='50' value="<%= teacher.getTeacherName()%>" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="telegramId" class="form-label">Chat ID (Telegram):</label>
                                            <input type="text" name="telegramId" class="form-control"  maxlength='10' value="<%= teacher.getTelegramId()%>" pattern="[0-9]{10}">
                                        </div>
                                    </div>
                                    <div class="row mb-">
                                        <div class="col-md-6">
                                            <label for="email" class="form-label">Email:</label>
                                            <input type="email" name="email" class="form-control"  maxlength='50' value="<%= teacher.getTeacherEmail()%>" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="contact" class="form-label">Contact No:</label>
                                            <input type="tel" name="contact" class="form-control"  maxlength='15' value="<%= teacher.getTeacherContact()%>" pattern="01[0-9]-[0-9]{7,8}" required>
                                        </div>
                                    </div>
                                    <div class="container d-flex justify-content-center align-items-center">
                                        <div class="row col-md-10 d-flex align-items-center" style="background: linear-gradient(to bottom right, #ffffff 0%, #ccffff 100%); border-radius: 10px; box-shadow: 2px 2px 2px black; padding: 20px;">
                                            <div class="col-md-6 mb-1">
                                                <label for="username" class="form-label">Username:</label>
                                                <input type="text" name="username" class="form-control" maxlength='15' value="<%= user.getUsername()%>" readonly>
                                            </div>
                                            <div class="col-md-6 mb-1">
                                                <label for="password" class="form-label">Password:</label>
                                                <input type="password" name="password" class="form-control" required>
                                                <i class="fas fa-eye" style="color:#1fb1c4;" onclick="togglePasswordVisibility(this)"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-2 pt-2">
                                        <div id="formButton">
                                            <input style="background-color: #9da0a1" type="reset" value="Cancel" onclick='window.location.href = "TEACHERS.jsp"'>
                                            <button type="submit" id="button" name="action" value="manageProfile">Confirm</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function goToHome() {
                window.location.href = "HOME.jsp";
            }

            function togglePasswordVisibility(icon) {
                var passwordField = icon.previousElementSibling;
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.className = "fas fa-eye-slash";
                } else {
                    passwordField.type = "password";
                    icon.className = "fas fa-eye";
                }
            }
        </script>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>


</html>
