<%-- 
    Document   : addStaff
    Created on : May 21, 2024, 11:19:47 PM
    Author     : ACER
--%>

<%@page import="com.Dao.TeacherDao"%>
<%@page import="com.Model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
        <title>Add Staff</title>  
        <style>
            .card-registration{
                margin-top:5%;
            }
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
            String teacherId = request.getParameter("teacherId");
            Teacher teacher = null;
            if (teacherId != null && !teacherId.isEmpty()) {
                int id = Integer.parseInt(teacherId);
                teacher = TeacherDao.getTeacherById(id);
                request.setAttribute("teacher", teacher);
            }
        %>

        <section id="section" class="vh-80 gradient-custom">
            <ul class="breadcrumb">
                <li><a href="HOME.jsp">Home</a></li>
                <li><a href="TEACHERS.jsp">Teachers</a></li>
                <li>Edit Teacher</li>
            </ul>
            <div class="container h-70"> 
                <div class="row justify-content-center align-items-center h-60">
                    <div class="col-12 col-lg-9 col-xl-9">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-2 p-md-4">
                                <h3 class="mb-3 pt-3 pb-md-0 mb-md-3"id="title">Update Teacher</h3>
                                <form method="post" action="TeacherServlet">
                                    <input type="hidden" name="teacherId" value='<%=teacher.getTeacherID()%>'>

                                    <div class="row">
                                        <div class="col-md-6 mb-2">
                                            <div data-mdb-input-init class="form-outline">
                                                <label class="form-label" for="name">Name:</label>
                                                <input type="text" name="name" value='<%=teacher.getTeacherName()%>' class="form-control form-control-lg" maxlength="50" required/>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-2">
                                            <div data-mdb-input-init class="form-outline">
                                                <label class="form-label" for="telegramId">Chat ID(Telegram):</label>
                                                <input type="text" name="telegramId" value='<%=teacher.getTelegramId()%>' class="form-control form-control-lg"  maxlength="10" placeholder="eg. 1234567890" pattern="[0-9]{10}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4 mb-2 d-flex align-items-center">
                                            <div data-mdb-input-init class="form-outline">
                                                <label for="email" class="form-label">Email</label>
                                                <input type="email" name="email" id="email" value='<%=teacher.getTeacherEmail()%>' class="form-control form-control-lg"  maxlength="50" required />
                                            </div>
                                        </div>
                                        <div class="col-md-4 mb-2 d-flex align-items-center">
                                            <div data-mdb-input-init class="form-outline">
                                                <label for="contact" class="form-label">Contact:</label>
                                                <input type="tel" name="contactNo" id="contact" value='<%=teacher.getTeacherContact()%>' class="form-control form-control-lg" maxlength="15" placeholder="eg. 012-3456789" pattern="01[0-9]-[0-9]{7,8}" required />
                                            </div>
                                        </div>
                                        <div class="col-md-4 mb-2 d-flex align-items-center">
                                            <div data-mdb-input-init class="form-outline">
                                                <label for="role" class="form-label">Role</label>
                                                <select name="role" id="role" class="select form-control-lg" required>
                                                    <option value="Teacher" <%= (teacher != null && "Teacher".equals(teacher.getTeacherRole())) ? "selected" : ""%>>Teacher</option>
                                                    <option value="Principal" <%= (teacher != null && "Principal".equals(teacher.getTeacherRole())) ? "selected" : ""%>>Principal</option>
                                                    <option value="Assistant Principal" <%= (teacher != null && "Assistant Principal".equals(teacher.getTeacherRole())) ? "selected" : ""%>>Assistant Principal</option>
                                                    <option value="Part Time" <%= (teacher != null && "Part Time".equals(teacher.getTeacherRole())) ? "selected" : ""%>>Part Time</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-0 pt-2">
                                        <div id="formButton">
                                            <input style="background-color: #9da0a1" type="reset" value="Cancel" onclick="return viewTeacher()">
                                            <button type="submit" id="button" name="action" value="update">Update</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script>
            function viewTeacher() {
                window.location.href = "TEACHERS.jsp";
            }
        </script>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>



</html>
