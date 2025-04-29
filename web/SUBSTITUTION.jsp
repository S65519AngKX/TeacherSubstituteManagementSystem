<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.Model.SubstitutionAssignments"%>
<%@page import="com.Dao.SubstitutionAssignmentDao"%>
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
        <!--to print file as pdf-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js" integrity="sha512-GsLlZN/3F2ErC5ifS5QtgpiJtWd43JWSuIgh7mbzZ8zBps+dvLusV+eNQATqgA/HdeKFVgA5v3S/cIrLF7QnIg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/list.css">
        <title>Substitution Assignment History</title>
        <style>
            #title{
                font-size: 27px;
                margin:5px auto;
            }

            table tr td,th{
                text-align:  center;
            }
            table{
                margin-top: 0px;
            }
            #formButton{
                margin:1% 5%;
                text-align: center;
            }

            #formButton #history{
                background-color: #1fbfdb;
                color:white;
                border: 0px;
                border-radius:10px;
                padding:8px 20px;
                font-size:13px;
                margin:3px auto;
                width:fit-content;
                height:fit-content;
                box-shadow: 2px 2px 2px black;
            }
            #top{
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin:0 auto;
            }
            h5{
                margin: 10px 3%;
                padding: 10px 15px;
                background-color: #f0f0f0;
                border-left: 20px solid #1fbfdb;
                display: inline-block;
                border-radius: 5px;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            }
            #button4 {
                background-color: #1fbfdb;
                color: white;
                border: 0;
                border-radius: 10px;
                padding: 8px 5px;
                font-size: 13px;
                width: 120px;
                height: fit-content;
                box-shadow: 2px 2px 2px black;
                text-align: center;
                margin-right:3%;
                float: right;
                margin-bottom: 10px;
                clear: both;
                font-weight:500;
            }
            .new-substitution {
                border-top: 3px solid  #1fb1c4; /* Add top border for new substitutions */
            }
            @media only screen and (max-width: 768px) {
                #title{
                    font-size:22px;
                    margin-left: 20%;
                }
                #formButton #history{
                    font-size:11px;
                }

            </style>
        </head>


        <body>
            <header>
                <%@include file="header.jsp"%>
            </header>

            <div id="section">
                <div id="top">
                    <h1 id="title">Substitution Assignments</h1>
                    <div  id="formButton" class="d-flex justify-content-end mb-2">
                        <input id="history" type="button" style="background-color:#8d9394;" value="Request Substitution" onclick="window.location.href = 'requestSubstitution.jsp'"> 
                    </div>
                </div>
                <%
                    SimpleDateFormat formatter = new SimpleDateFormat("EEEE, yyyy-MM-dd");
                    String todayDate = formatter.format(new java.util.Date());
                %>
                <div id="printSection">
                    <h5>Date: <%= todayDate%></h5>               
                    <table>
                        <tr>
                            <th>Absent Teacher </th>
                            <th>Reason</th>
                            <th>Period</th>
                            <th>Subject</th>
                            <th>Class</th>
                            <th>Substitute Teacher</th>
                            <th>Remarks</th>
                        </tr>

                        <%
                            List<SubstitutionAssignments> list = SubstitutionAssignmentDao.displayTodaySubstitutionAssignment();
                            int lastSubstitutionId = 0;
                        %>

                        <% for (SubstitutionAssignments e : list) {%>
                        <tr class="editable-row assignment-row
                            <% if (e.getSubstitutionId() != lastSubstitutionId) { %>
                            new-substitution
                            <% }%>" 
                            data-assignment-id="<%= e.getSubstitutionId()%>" 
                            data-schedule-id="<%= e.getScheduleId()%>">

                            <td><%= TeacherDao.getTeacherNameById(e.getAbsentTeacherId())%></td>
                            <td><%= e.getReason()%></td>
                            <td><%= e.getPeriod()%></td>
                            <td><%= e.getSubjectName()%></td>
                            <td><%= e.getClassName()%></td>
                            <td><%= (e.getSubstituteTeacherID() != 0) ? TeacherDao.getTeacherNameById(e.getSubstituteTeacherID()) : ""%></td>
                            <td><%= (e.getRemarks() == null) ? "" : e.getRemarks()%></td>
                        </tr>
                        <%
                            lastSubstitutionId = e.getSubstitutionId();
                        %>
                        <% }%>
                    </table>
                </div>
                <button id="button4" class="btn btn-primary" style="margin-right:3%;" onclick="printPage()">Print</button>
            </div>
            <footer>
                <%@ include file="footer.jsp" %>
            </footer>
        </body>
        <script>
            function printPage() {
                const currentDate = new Date().toDateString();
                var fileName = currentDate + "_SubstitutionAssignemts.pdf";
                var element = document.getElementById('printSection');
                var opt = {
                    margin: 0.5,
                    filename: fileName,
                    html2canvas: {scale: 2},
                    jsPDF: {unit: 'in', format: 'letter', orientation: 'portrait'}
                };

                html2pdf().set(opt).from(element).save();
            }

        </script>
    </html>
