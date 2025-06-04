<%@page import="com.Dao.SubstitutionAssignmentDao"%>
<%@page import="com.Model.SubstitutionAssignments"%>
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
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/list.css">
        <title>Assignment History</title>
        <style>
            .delete-icon i{
                color: red;
                font-size:13px;
                align-items: center;
            }
            .delete-icon i:hover {
                color: darkred;
            }
            table tr td,th{
                text-align:  center;
            }
            .date-separator {
                font-weight: bold;
                text-align: center;
            }
            .date-header {
                font-size: 15px;
                background-color: #048291;
                color:white;
                text-align: center;
            }

            label,input{
                font-size:15px;
                margin:10px;
            }
            label{
                margin-left:3%;
            }
            select {
                margin-left:30%;
                font-size: 13px;
                padding: 3px 15px;
                border-radius: 5px;
                background-color: #f9f9f9;

            }

            select option {
                font-size: 13px;
                padding: 6px;
            }
            #button2{
                background-color: #1fbfdb;
                color:white;
                border: 0px;
                border-radius:10px;
                padding:2px 10px;
                font-size:12px;
                margin-left 5%;
                width:fit-content;
                box-shadow: 2px 2px 2px black;
            }

            @media (min-width: 480px) and (max-width: 767px){
                #dateForm label{
                    font-size: 10px;
                }
                select {
                    margin-left:20%;
                    font-size: 10px;
                    padding: 3px 8px;
                }
                select option {
                    font-size: 10px;
                    padding: 6px;
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
                <li><a href="SUBSTITUTIONS.jsp">Substitutions</a></li>
                <li>Substitution Assignments History</li>
            </ul>
            <form id="dateForm" style='margin-bottom:10px;' method="GET" action="SubstitutionAssignmentServlet">
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate">

                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate">

                <select id="rangeSelect" style="margin-left:5%;" onchange="applyQuickRange(this.value)">
                    <option value="">-- Select Range --</option>
                    <option value="today">Today</option>
                    <option value="last7">Last 7 Days</option>
                    <option value="last30">Last 30 Days</option>
                    <option value="thisMonth">This Month</option>
                    <option value="lastMonth">Last Month</option>
                    <option value="all">Show All</option>
                </select>

                <button id="button2" type="submit" name="action" value='filter'>Filter</button>
            </form>

            <table class="substitutionReport">
                <tr>
                    <th>Absent Teacher</th>
                    <th>Reason</th>
                    <th>Period</th>
                    <th>Subject</th>
                    <th>Class</th>
                    <th>Substitute Teacher</th>
                    <th>Remarks</th>
                </tr>
                <%
                    List<SubstitutionAssignments> subAssignList = (List<SubstitutionAssignments>) request.getAttribute("assgnList");
                    java.sql.Date lastSubstitutionDate = null;
                    if (subAssignList != null) {
                        for (SubstitutionAssignments e : subAssignList) {
                            java.sql.Date currentSubstitutionDate = e.getSubstitutionDate();
                            if (lastSubstitutionDate == null || !currentSubstitutionDate.equals(lastSubstitutionDate)) {
                %>
                <tr class="date-separator">
                    <td colspan="7" class="date-header"><%= currentSubstitutionDate%></td>
                </tr>
                <% }%>

                <tr class="editable-row assignment-row">
                    <td><%= TeacherDao.getTeacherNameById(e.getAbsentTeacherId())%></td>
                    <td><%= e.getReason()%></td>
                    <td><%= e.getPeriod()%></td>
                    <td><%= e.getSubjectName()%></td>
                    <td><%= e.getClassName()%></td>
                    <td><%= (e.getSubstituteTeacherID() != 0) ? TeacherDao.getTeacherNameById(e.getSubstituteTeacherID()) : ""%></td>
                    <td><%= (e.getRemarks() == null) ? "" : e.getRemarks()%></td>
                </tr>
                <% lastSubstitutionDate = currentSubstitutionDate; %> 
                <% }
                    }
                %>
            </table>
            <button id="button" type="button" onclick="window.location.href = 'SUBSTITUTIONS.jsp';">BACK</button>
        </div>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>

        <script>
            function formatDateToInput(date) {
                return date.toISOString().split('T')[0];
            }

            function applyQuickRange(range) {
                const today = new Date();
                let start, end;

                switch (range) {
                    case "today":
                        start = end = today;
                        break;
                    case "yesterday":
                        start = end = new Date(today.setDate(today.getDate() - 1));
                        break;
                    case "last7":
                        start = new Date();
                        start.setDate(today.getDate() - 6);
                        end = new Date();
                        break;
                    case "last30":
                        start = new Date();
                        start.setDate(today.getDate() - 29);
                        end = new Date();
                        break;
                    case "thisMonth":
                        start = new Date(today.getFullYear(), today.getMonth(), 1);
                        end = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                        break;
                    case "lastMonth":
                        start = new Date(today.getFullYear(), today.getMonth() - 1, 1);
                        end = new Date(today.getFullYear(), today.getMonth(), 0);
                        break;
                    case "all":
                        document.getElementById("startDate").value = "";
                        document.getElementById("endDate").value = "";
                        return;
                    default:
                        return;
                }

                document.getElementById("startDate").value = formatDateToInput(start);
                document.getElementById("endDate").value = formatDateToInput(end);
            }

        </script>

    </body>
</html>

