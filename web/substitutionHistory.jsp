<%@page import="com.Model.Leave"%>
<%@page import="com.Dao.LeaveDao"%>
<%@page import="com.Model.SubstitutionRequestPeriod"%>
<%@page import="com.Dao.SubstitutionRequestPeriodDao"%>
<%@page import="com.Model.Substitution"%>
<%@page import="com.Dao.SubstitutionDao"%>
<%@page import="java.sql.Date"%>
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

            #title,#title2 {
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
            <ul class="breadcrumb">
                <li><a href="HOME.jsp">Home</a></li>
                <li><a href="SUBSTITUTIONS.jsp">Substitutions</a></li>
                <li>Today Substitutions Requests</li>
            </ul>
            <h1 id="title">Substitution Request & Leave Application History</h1>
            <table>
                <tr>
                    <th>Teacher Name</th>
                    <th>Substitution Type</th>
                    <th>Period</th>
                    <th>Reason</th>
                    <th>Notes</th>
                    <th>Actions</th>
                </tr>

                <%
                    List<Substitution> list = SubstitutionDao.displayAllSubstitution();
                    Date lastSubstitutionDate = null;
                %>

                <% for (Substitution e : list) { %>
                <%
                    Date currentSubstitutionDate = e.getSubstitutionDate();
                    if (lastSubstitutionDate == null || !currentSubstitutionDate.equals(lastSubstitutionDate)) {
                %>
                <tr class="date-separator">
                    <td colspan="7" class="date-header"><%= currentSubstitutionDate%></td>
                </tr>
                <% }%>

                <tr class="editable-row assignment-row">
                    <td><%= TeacherDao.getTeacherNameById(e.getTeacherID())%></td>
                    <td><%= e.getType()%></td>
                    <td>
                        <%
                            if (e.getType().equalsIgnoreCase("Substitution Request")) {
                                List<SubstitutionRequestPeriod> periodsSub = SubstitutionRequestPeriodDao.getSubstitutionRequestPeriod(e.getSubstitutionRequestId());
                                for (SubstitutionRequestPeriod ps : periodsSub) {
                        %>
                        <%= ps.getSubstitutionRequestPeriod()%>&nbsp;
                        <%
                            }
                        } else {
                            List<Integer> periodLeave = SubstitutionDao.getLeavePeriod(e.getSubstitutionDate(), e.getTeacherID());
                            for (Integer pl : periodLeave) {
                        %>
                        <%= pl%>&nbsp;
                        <%
                                }
                            }
                        %>
                    </td>                    
                    <td><%= e.getReason()%></td>
                    <td><%= (e.getNotes() == null) ? "" : e.getNotes()%></td>
                    <td>
                        <a href="<%= request.getContextPath()%>/SubstitutionServlet?action=delete&substitutionId=<%= e.getSubstitutionId()%>"
                           class="delete-icon" 
                           onclick="return confirm('Do you want to delete this substitution record?');">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </td>                
                </tr>
                <% lastSubstitutionDate = currentSubstitutionDate; %> 
                <% }%>
            </table>
            <br>
            <h1 id="title2">Unprocessed Leave</h1>
            <table>
                <tr>
                    <th>Leave ID</th>
                    <th>Teacher Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Reason</th>
                    <th>Notes</th>
                    <th>Status</th>
                </tr>
                <%
                    List<Leave> list1 = LeaveDao.getAllTodayUnprocessedLeave();
                    for (Leave e : list1) {
                        Teacher teacher = TeacherDao.getTeacherById(e.getAbsentTeacherID());
                %>
                <tr>
                    <td><%= e.getLeaveID()%></td>
                    <td><%= teacher != null ? teacher.getTeacherName() : "Not found"%></td>
                    <td><%= e.getLeaveStartDate()%></td>
                    <td><%= e.getLeaveEndDate()%></td>
                    <td><%= e.getLeaveReason()%></td>
                    <td><%= e.getLeaveNotes()%></td>
                    <%
                        if (e.getLeaveStatus().equalsIgnoreCase("Pending")) {
                    %>                    
                    <td style='color:red;font-weight: bold'><%= e.getLeaveStatus()%></td>
                    <%
                    } else {
                    %>                    
                    <td><%= e.getLeaveStatus()%></td>
                    <%
                        }
                    %>
                </tr>
                <%
                    }
                %>
            </table>
            <button id="button" class="btn btn-primary" onclick="window.location.href = 'SUBSTITUTIONS.jsp'">BACK</button>
        </div>

        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>
</html>
