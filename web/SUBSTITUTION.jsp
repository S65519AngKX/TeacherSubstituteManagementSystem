<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.ZoneId"%>
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
                margin:0 8%;
            }
            h5{
                margin: 10px 10%;
                padding: 10px 15px;
                background-color: #f0f0f0;
                border-left: 20px solid #1fbfdb;
                display: inline-block;
                border-radius: 5px;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            }
            #button {
                background-color: #1fbfdb;
                color: white;
                border: 0;
                border-radius: 10px;
                padding: 8px 20px;
                font-size: 13px;
                width: fit-content;
                height: fit-content;
                box-shadow: 2px 2px 2px black;
                text-align: center;
                margin-right:10% !important;
                float: right;
                margin-bottom: 10px;
                clear: both;
                font-weight:500;
            }
            .new-substitution {
                border-top: 3px solid  #1fb1c4; /* Add top border for new substitutions */
            }
            @media only screen and (max-width: 768px) {
                #top{
                    margin:0 5%;
                }
                #title{
                    font-size:25px;
                    margin-left: 20%;
                }
                #formButton #history, #button{
                    font-size:11px;
                }
                #button{
                    margin-right:5% !important;
                }
                #printSection h5{
                    font-size:13px;
                    margin-left:5%;
                }
                #printSection{
                    overflow-x: auto;
                }
            }
            @media only screen and (max-width: 479px) {
                #top{
                    margin:0 1%;
                }
                #title{
                    font-size:23px;
                    margin-left: 10%;
                }
                #formButton #history, #button{
                    font-size:11px;
                    padding: 8px 10px;

                }
                #printSection h5{
                    font-size:12px;
                }
            }

            /*for printing purpose*/
            .print-mode * {
                background: white !important;
                color: black !important;
                border-color: black !important;
                box-shadow: none !important;
            }

            .print-mode .report-table {
                width: 100% !important;
                table-layout: fixed !important;
                font-size: 10px !important;
                border: 1px solid black;
            }

            .print-mode td, .print-mode th {
                padding: 4px 6px !important;
                font-size: 10px !important;
                border: 1px solid black;
            }
            .print-mode th {
                font-size: 9px !important;
            }

            .print-mode h5 {
                font-size: 11px !important;
                margin: 5px 10px !important;
                padding: 5px 10px !important;
                background: white !important;
                border-left: 3px solid black !important;
            }

            .print-mode #printSection,
            .print-mode .card,
            .print-mode .container,
            .print-mode .row {
                width: 100% !important;
                margin: 0 !important;
                padding: 0 !important;
                max-width: 100% !important;
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
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, yyyy-MM-dd");
                ZoneId zone = ZoneId.of("Asia/Kuala_Lumpur");
                LocalDate today = LocalDate.now(zone); 
                String todayDate = today.format(formatter);
            %>
                
            <div id="printSection">
                <h5>Date: <%= todayDate%></h5>               
                <table class="report-table">
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
                        <% String time = "";
                            switch (e.getPeriod()) {
                                case 1:
                                    time = "7:40-8:10";
                                    break;
                                case 2:
                                    time = "8:10-8:40";
                                    break;
                                case 3:
                                    time = "8:40-9:10";
                                    break;
                                case 4:
                                    time = "9:10-9:40";
                                    break;
                                case 5:
                                    time = "9:40-10:10";
                                    break;
                                case 6:
                                    time = "10:10-10:40";
                                    break;
                                case 7:
                                    time = "10:40-11:10";
                                    break;
                                case 8:
                                    time = "11:10-11:40";
                                    break;
                                case 9:
                                    time = "11:40-12:10";
                                    break;
                                case 10:
                                    time = "12:10-12:40";
                                    break;
                                case 11:
                                    time = "12:40-13:10";
                                    break;
                            }
                        %>
                        <td style="text-align: left;font-size:0.9em"><span style="font-weight: bold;"><%= e.getPeriod()%></span> (<%=time%>)</td>
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
            <button id="button" class="btn btn-primary" style="margin-right:3%;" onclick="printPage()">Print</button>
        </div>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>
    <script>
        function printPage() {
            const currentDate = new Date().toDateString();
            const fileName = currentDate + "_SubstitutionAssignments.pdf";
            const element = document.getElementById('printSection');

            // Add print-mode class to apply styles
            element.classList.add('print-mode');

            const opt = {
                margin: 0.5,
                filename: fileName,
                html2canvas: {
                    scale: 2,
                    useCORS: true,
                    backgroundColor: "#ffffff"
                },
                jsPDF: {
                    unit: 'in',
                    format: 'a4',
                    orientation: 'portrait'
                },
                pagebreak: {mode: ['avoid-all', 'css', 'legacy']}
            };

            html2pdf().set(opt).from(element).save().then(() => {
                // Remove class after saving
                element.classList.remove('print-mode');
            });
        }


    </script>
</html>
