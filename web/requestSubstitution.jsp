<%@page import="util.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="com.Dao.ScheduleDao, com.Model.Schedule" %>
<%
    String selectedDate = request.getParameter("substitutionRequestDate");
    int teacherId = Integer.parseInt((String) session.getAttribute("teacherId"));
    List<Schedule> schedules = new ArrayList<>();

    if (selectedDate != null && !selectedDate.isEmpty()) {
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = formatter.parse(selectedDate);
            java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());
            Connection con = Database.getConnection();
            schedules = ScheduleDao.getScheduleByTeacherAndDate(teacherId, sqlDate, con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Stardos+Stencil" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" />
        <link rel="stylesheet" href="https://apalfrey.github.io/select2-bootstrap-5-theme/assets/css/docs.css" />
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.0/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/anchor-js/anchor.min.js"></script>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/form.css">
        <title>Request Substitution</title>
        <style>
            #top{
                display: flex;
                align-items: center;
            }
            #title{
                font-size:30px;
                margin:0;
                margin-left:30%;
                padding:0;
            }
            #button {
                background-color: grey;
                color:white;
                border: 0px;
                border-radius:10px;
                padding:8px 20px;
                font-size:15px;
                margin:5px 20px 0px 20px;
                box-shadow: 2px 2px 2px black;
            }
            #formButton #history{
                font-size:13px;
            }
            @media only screen and (max-width: 768px) {
                #section {
                    flex-grow: 1;
                    margin: 0px auto;
                    padding: 2px;
                    max-width: 90%;
                    overflow:auto;
                }
                #title{
                    font-size:22px;
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

            <div id="section" >
                <ul class="breadcrumb" style="margin:0;">
                    <li><a href="HOME.jsp">Home</a></li>
                    <li><a href="SUBSTITUTION.jsp">View Substitution Assignments</a></li>
                    <li>Request Substitution</li>
                </ul>
                <div class="container h-60"> 
                    <div class="row justify-content-center align-items-center h-60">
                        <div class="col-12 col-lg-10 col-xl-10">
                            <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                                <div class="card-body p-0 p-md-1">
                                    <form method="post" action="saveSubstitutionRequest" id="requestSubstitutionForm" class="container mt-3 mb-0">
                                        <div id="top">
                                            <h1 id="title">Request Substitution</h1>
                                            <div  id="formButton" class="d-flex justify-content-end mb-0">
                                                <input id="history" type="button" style="background-color:#8d9394;" value="History" onclick="window.location.href = 'substitutionRequestHistory.jsp'"> 
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12">
                                                <input type="hidden" name="requestTeacherId" value="<%=session.getAttribute("teacherId")%>">
                                            </div>

                                            <div class="col-12 mb-1">
                                                <label for="substitutionRequestDate" class="form-label">Date:</label>
                                                <div class="input-group">
                                                    <input type="date" id="substitutionRequestDate" name="substitutionRequestDate" class="form-control" required onchange="searchPeriod()">
                                                </div>
                                            </div>

                                            <div class="col-12 mb-1">
                                                <label for="substitutionRequestPeriod" class="form-label">Period</label>
                                                <select name="substitutionRequestPeriod" class="form-select" id="multiple-select-field" data-placeholder="Choose period" multiple>
                                                    <% if (!schedules.isEmpty()) {
                                        for (Schedule schedule : schedules) {%>
                                                    <option value="<%= schedule.getSchedulePeriod()%>">
                                                        <%= schedule.getSchedulePeriod()%> - <%= schedule.getClassName()%>(<%= schedule.getScheduleSubject()%>)
                                                    </option>
                                                    <% }
                                } else if (selectedDate != null) { %>
                                                    <option disabled>No periods available for this date</option>
                                                    <% }%>
                                                </select>
                                            </div>

                                            <div class="col-12 mb-1">
                                                <label for="substitutionRequestReason" class="form-label">Reason:</label>
                                                <select name="substitutionRequestReason" class="form-select" required>
                                                    <option value="Medical Appointment">Medical Appointment</option>
                                                    <option value="Event">Event</option>
                                                    <option value="Personal Reason">Personal Reason</option>
                                                </select>
                                            </div>

                                            <div class="col-12 mb-0">
                                                <label for="substitutionRequestNotes" class="form-label">Notes:</label>
                                                <textarea name="substitutionRequestNotes" class="form-control" placeholder="Please enter your special requests for substitution assignments" maxlength="200" rows="4"></textarea>
                                            </div>

                                            <div id="formButton">
                                                <input type="submit" value="Apply">
                                                <button id="button" type="button" onclick="window.location.href = 'SUBSTITUTION.jsp'">Back</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function searchPeriod() {
                    const date = document.getElementById("substitutionRequestDate").value;
                    if (date) {
                        // Store selected date in localStorage before refreshing
                        localStorage.setItem("selectedDate", date);

                        // Reload the page with the selected date as a query parameter
                        window.location.href = "requestSubstitution.jsp?substitutionRequestDate=" + encodeURIComponent(date);
                    }
                }

                // Restore the selected date on page load
                document.addEventListener("DOMContentLoaded", function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    const savedDate = urlParams.get("substitutionRequestDate") || localStorage.getItem("selectedDate");

                    if (savedDate) {
                        document.getElementById("substitutionRequestDate").value = savedDate;
                    }
                });
                document.addEventListener('DOMContentLoaded', function () {
                    const dateInput = document.getElementById('substitutionRequestDate');
                    document.getElementById('requestSubstitutionForm').addEventListener('submit', function (event) {
                        const dateValue = new Date(dateInput.value);
                        const today = new Date();
                        today.setHours(0, 0, 0, 0);
                        dateValue.setHours(0, 0, 0, 0);
                        if (dateValue < today) {
                            alert('Date must be today or later');
                            event.preventDefault();
                        }
                    });
                });

                document.addEventListener('DOMContentLoaded', function () {
                    $('#multiple-select-field').select2({
                        theme: "bootstrap-5",
                        width: $(this).data('width') ? $(this).data('width') : $(this).hasClass('w-100') ? '100%' : 'style',
                        placeholder: $(this).data('placeholder'),
                        closeOnSelect: false,
                    });
                });
            </script>

            <footer>
                <%@ include file="footer.jsp" %>
            </footer>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>
    </html>
