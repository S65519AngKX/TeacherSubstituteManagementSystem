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
        <link rel="stylesheet" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.css" />
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/list.css">        
        <title>Manage Teacher</title>
        <style>
            #title {
                font-size: 25px;
                margin: 0 auto;
            }
            th, td {
                text-align: left;
                font-size: 13px;
            }
            #section {
                overflow-x: hidden;
            }
            .edit-icon{
                color:grey;
            }

            @media (max-width: 767px) {
                .card {
                    width: 90%;
                    margin: 10px auto;
                }
                #title {
                    font-size: 20px;
                }
                th, td {
                    font-size: 12px;
                }
            }

        </style>
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <div id="section" >

            <!-- Area Chart -->
            <div class="row justify-content-center">

                <div class="col-xl-11 col-lg-11">
                    <div class="card shadow mb-4 mt-4">
                        <!-- Card Header - Dropdown -->
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 id="title" >Manage Teacher</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="teacherTable" width="95%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Teacher ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Contact No</th>
                                            <th>Role</th>
                                            <th>Telegram ID</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
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
                                                <a href="editTeacher.jsp?teacherId=<%= e.getTeacherID()%>" class="edit-icon">
                                                    <i class="fas fa-edit"></i></a>&nbsp;&nbsp;&nbsp;
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

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button id="button" type="button" onclick="window.location.href = 'addTeacher.jsp';">Add Teacher</button>
        </div>

    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/2.2.2/js/dataTables.js"></script>

    <script>
                document.addEventListener('DOMContentLoaded', function () {


                    let table = new DataTable('#teacherTable');

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
