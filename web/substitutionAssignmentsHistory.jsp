<%@page import="java.sql.Date"%>
<%@page import="com.Model.SubstitutionAssignments"%>
<%@page import="com.Dao.SubstitutionAssignmentDao"%>
<%@page import="com.Model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
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
        <title>Substitution Assignment History</title>
        <style>
            #title {
                font-size: 27px;
                margin: 5px auto;
            }

            table tr td, th {
                text-align: center;
            }

            table {
                margin-top: 0px;
            }

            .date-separator {
                font-weight: bold;
                text-align: center;
            }
            .date-header {
                font-size: 15px;
                background-color: #048291;
                color:white;
            }

            @media only screen and (max-width: 768px) {
                #title {
                    font-size: 22px;
                    margin-left: 20%;
                }

                #formButton #history {
                    font-size: 11px;
                }
            }
        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <div id="section">
            <h1 id="title">Substitution Assignments History</h1>
            <table>
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
                    List<SubstitutionAssignments> list = SubstitutionAssignmentDao.displayAllSubstitutionAssignment();
                    Date lastSubstitutionDate = null;
                %>

                <% for (SubstitutionAssignments e : list) { %>
                <%
                    Date currentSubstitutionDate = e.getSubstitutionDate();
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
                <% }%>
            </table>

            <button id="button" class="btn btn-primary" onclick="window.location.href = 'SUBSTITUTIONS.jsp'">BACK</button>
        </div>

        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>
</html>
