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
            .delete-icon i{
                color: red;
                font-size:13px;
                align-items: center;
            }

            .delete-icon i:hover {
                color: darkred;
            }
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

            @media screen and (max-width: 767px) {
                .card {
                    width: 90%;
                    margin: 10px auto;
                }
                #title {
                    font-size: 25px;
                }
                th, td {
                    font-size: 12px;
                }
            }
            @media screen and (max-width: 479px) {
                .card{
                    width: 100%;
                    margin:0;
                }
               
            }

        </style>
    </head>


    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <div id="section">
            <ul class="breadcrumb">
                <li><a href="HOME.jsp">Home</a></li>
                <li><a href="LEAVES.jsp">Leaves</a></li>
                <li>Leave History</li>
            </ul>
            <!-- Area Chart -->
            <div class="row justify-content-center">

                <div class="col-xl-11 col-lg-11">
                    <div class="card shadow mb-4 mt-4">
                        <!-- Card Header - Dropdown -->
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 id="title" >Leave History</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="LeaveTable" width="90%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Teacher Name</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Reason</th>
                                            <th>Notes</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Leave> list = LeaveDao.getAllProcessedLeave();
                                            for (Leave e : list) {
                                                Teacher teacher = TeacherDao.getTeacherById(e.getAbsentTeacherID());
                                        %>
                                        <tr>
                                            <td><%= teacher != null ? teacher.getTeacherName() : "Not found"%></td>
                                            <td><%= e.getLeaveStartDate()%></td>
                                            <td><%= e.getLeaveEndDate()%></td>
                                            <td><%= e.getLeaveReason()%></td>
                                            <td><%= e.getLeaveNotes()%></td>
                                            <td><%= e.getLeaveStatus()%></td> 
                                            <td>
                                                <a href="<%= request.getContextPath()%>/LeaveServlet?action=delete&leaveId=<%= e.getLeaveID()%>" 
                                                   onclick="return confirm('Do you want to delete this leave record?');" 
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

            <button id="button" type="button" onclick="window.location.href = 'LEAVES.jsp';">BACK</button>
        </div>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.datatables.net/2.2.2/js/dataTables.js"></script>

        <script>
                document.addEventListener('DOMContentLoaded', function () {
                    let table = new DataTable('#LeaveTable');
                });
        </script>
    </body>
</html>
