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
        <link rel="stylesheet" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.css" />
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/list.css">
        <title>Leave History</title>
        <style>
            #title {
                font-size: 25px;
                margin: 0 auto;
            }
            table tr td,th{
                text-align:  center;
                font-size: 13px;
            }
            #section {
                overflow-x: hidden;
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
        <div id="section">
            <ul class="breadcrumb">
                <li><a href="HOME.jsp">Home</a></li>
                <li><a href="LEAVE.jsp">Leave</a></li>
                <li>Leave History</li>
            </ul>
            <!-- Area Chart -->
            <div class="row justify-content-center">

                <div class="col-xl-11 col-lg-11">
                    <div class="card shadow mb-4 mt-4">
                        <!-- Card Header - Dropdown -->
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 id="title" >Teacher Leave History</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="teacherLeaveTable" width="75%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Leave ID</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Reason</th>
                                            <th>Notes</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
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

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button id="button" type="button" onclick="window.location.href = 'LEAVE.jsp';">BACK</button>
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
                    let table = new DataTable('#teacherLeaveTable');
                });
    </script>
</html>
