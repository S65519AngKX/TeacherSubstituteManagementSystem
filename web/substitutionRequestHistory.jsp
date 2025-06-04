<%-- 
    Document   : substitutionRequestHistory
    Created on : Mar 12, 2025, 11:08:25 PM
    Author     : Khe Xin
--%>

<%@page import="com.Dao.SubstitutionRequestPeriodDao"%>
<%@page import="com.Model.SubstitutionRequestPeriod"%>
<%@page import="com.Model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.Model.SubstitutionRequest"%>
<%@page import="com.Dao.SubstitutionRequestDao"%>
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
        <title>Substitution Request History</title>
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
            <ul class="breadcrumb" style="margin:0;">
                <li><a href="HOME.jsp">Home</a></li>
                <li><a href="SUBSTITUTION.jsp">View Substitution Assignments</a></li>
                <li><a href="requestSubstitution.jsp">Request Substitution</a></li>
                <li>Substitution Requests History</li>
            </ul>
            <div class="row justify-content-center">

                <div class="col-xl-11 col-lg-11">
                    <div class="card shadow mb-4 mt-4">
                        <!-- Card Header - Dropdown -->
                        <div
                            class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 id="title" >Substitution Request History</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="historyTable" width="60%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Period</th>
                                            <th>Reason</th>
                                            <th>Notes</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            String teacherIdStr = (String) session.getAttribute("teacherId");
                                            List<SubstitutionRequest> list = SubstitutionRequestDao.getSubstitutionRequestByTeacherId(Integer.parseInt(teacherIdStr));
                                            for (SubstitutionRequest e : list) {
                                        %>
                                        <tr>
                                            <td><%= e.getSubstitutionRequestDate()%></td>
                                            <td>
                                                <%
                                                    List<SubstitutionRequestPeriod> periods = SubstitutionRequestPeriodDao.getSubstitutionRequestPeriod(e.getSubstitutionRequestId());
                                                    for (SubstitutionRequestPeriod p : periods) {%>
                                                <%= p.getSubstitutionRequestPeriod()%>&nbsp;
                                                <%}%></td>
                                            <td><%= e.getSubstitutionRequestReason()%></td>
                                            <td><%= e.getSubstitutionRequestNotes()%></td>
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
            <button id="button" type="button" onclick="window.location.href = 'requestSubstitution.jsp';">BACK</button>

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


                    let table = new DataTable('#historyTable');


                });
    </script>

</html>
