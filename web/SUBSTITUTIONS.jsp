<%@page import="util.Database"%>
<%@page import="com.Model.Teacher"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.Dao.TeacherDao"%>
<%@page import="com.Dao.SubstitutionAssignmentDao"%>
<%@page import="com.Model.SubstitutionAssignments"%>
<%@page import="com.Model.Substitution"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.Dao.SubstitutionDao"%>  

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
        <title>SUBSTITUTIONS</title>
        <style>
            #top,#bottom{
                display: flex;
                align-items: center;
            }
            #title{
                font-size: 30px;
                margin:5px auto 0px auto;
            }
            #button4,#button5{
                color: white;
                border: 0;
                border-radius: 10px;
                padding: 5px 20px;
                font-size: 13px;
                width: fit-content;
                height: fit-content;
                box-shadow: 2px 2px 2px black;
                text-align: center;
                margin:auto;
                margin-right: 30px;
            }
            table tr td,th{
                text-align:  center;
            }
            #section {
                flex-grow: 1;
                margin: 0px auto;
                padding: 2px;
                width: 100%;
                overflow:auto;
            }
            h5{
                margin: 0px 3%;
                padding: 10px 15px;
                background-color: #f0f0f0;
                border-left: 20px solid #1fbfdb;
                display: inline-block;
                border-radius: 5px;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            }
            .new-substitution {
                border-top: 3px solid  #1fb1c4; /* Add top border for new substitutions */
            }
            select {
                font-size: 10px;
                border: 1.5px solid #1fb1c4;
                border-radius: 5px;
                padding: 5px;
                cursor: pointer;
                background-color: #defcfc;
                width: auto;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            #teacherSelect{
                width:170px;
            }
            #remarkSelect{
                width:100px;
            }

            option {
                font-size: 12px;
            }
            #button1, #button2, #button3 {
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
            @media (min-width: 480px) and (max-width: 767px){
                h5{
                    padding: 5px 10px;
                    font-size: 0.95em !important;
                }
                #teacherSelect{
                    width:120px;
                }
                #remarkSelect{
                    width:60px;
                }
                th, td {
                    padding: 2px;
                    font-size: 11px;
                }
                #title {
                    font-size: 23px;
                }
                table {
                    margin: 3px auto;
                }
                th {
                    font-size: 11px;
                }
                .delete-icon i{
                    font-size:10px;
                }
                #button1, #button2, #button3{
                    padding:5px 8px;
                    font-size:11px;
                    margin-bottom: 10px;
                }
                #button4, button5{
                    padding:5px 10px;
                    font-size: 11px;
                    margin-right: 15px;
                }
            }

        </style>
    </head>


    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <div id="section">
            <div id="top">
                <h1 id="title">Substitution Assignment</h1>
                <div  id="formButton" class="d-flex justify-content-end mb-0">
                    <input id="button4" type="button" style="background-color:#8d9394;" value="Substitution History" onclick="window.location.href = 'substitutionHistory.jsp'"> 
                    <input id="button5" type="button" style="background-color:#8d9394;" value="Leave History" onclick="window.location.href = 'todayLeave.jsp'"> 
                </div>
            </div>            
            <form method="post" action="SubstitutionAssignmentServlet">
                <%
                    SimpleDateFormat formatter = new SimpleDateFormat("EEEE, yyyy-MM-dd");
                    String todayDate = formatter.format(new java.util.Date());
                %>
                <h5>Date: <%= todayDate%></h5>      
                <table style="margin-top:0px;">
                    <tr>
                        <th>Absent Teacher </th>
                        <th>Reason</th>
                        <th>Period</th>
                        <th>Subject</th>
                        <th>Class</th>
                        <th>Substitute Teacher</th>
                        <th>Remarks</th>
                        <th>Action</th>
                        <th>Notes</th>
                    </tr>

                    <%
                        List<SubstitutionAssignments> list = SubstitutionAssignmentDao.getAllTodaySubstitutionAssignment();
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
                        <td>
                            <select name="substituteTeacherId" id='teacherSelect'>
                                <%
                                    try {
                                        Connection con = Database.getConnection();

                                        // Get the list of suggested substitute teachers
                                        List<Teacher> teachers = SubstitutionAssignmentDao.getSuggestedSubstitute(e.getSubstitutionDate(), e.getPeriod(), e.getScheduleDay(), e.getClassName(), e.getSubjectName());
                                        Integer selectedTeacherId = e.getSubstituteTeacherID();
                                        String remarks = (e.getRemarks() != null) ? e.getRemarks() : "";

                                        if (selectedTeacherId != null && selectedTeacherId != 0) {
                                %>
                                <option value="<%= selectedTeacherId%>" selected>
                                    <%= TeacherDao.getTeacherNameById(selectedTeacherId)%>
                                </option>
                                <%
                                    }
                                    if ((selectedTeacherId == null || selectedTeacherId == 0)
                                            && (remarks.equalsIgnoreCase("Split Class")
                                            || remarks.equalsIgnoreCase("Cancelled")
                                            || remarks.equalsIgnoreCase("Event"))) {
                                %>
                                <option value="0"> </option>
                                <%}
                                    if (teachers == null || teachers.isEmpty()) {
                                %>
                                <option value="0">No suitable substitute</option>
                                <%
                                } else {
                                    for (Teacher teacher : teachers) {
                                        int teacherId = teacher.getTeacherID();
                                        String teacherName = teacher.getTeacherName();
                                        if (selectedTeacherId == teacherId) {
                                            continue;
                                        }
                                %>
                                <option value="<%= teacherId%>"><%= teacherName%></option>
                                <%
                                        }
                                    }
                                %>
                                <option value="0"> </option>
                                <%
                                        con.close();
                                    } catch (Exception q) {
                                        out.println("<option>Error fetching teacher list</option>");
                                        q.printStackTrace();
                                    }
                                %>                            
                            </select>
                        </td>
                        <td>
                            <select name="remarks" id='remarkSelect'>
                                <option value="" <%= e.getRemarks() == null || e.getRemarks().isEmpty() ? "selected" : ""%>></option>
                                <option value="Split Class" <%= "Split Class".equals(e.getRemarks()) ? "selected" : ""%>>Split Class</option>
                                <option value="Combine Class" <%= "Combine Class".equals(e.getRemarks()) ? "selected" : ""%>>Combine Class</option>
                                <option value="Event" <%= "Event".equals(e.getRemarks()) ? "selected" : ""%>>Event</option>
                                <option value="Cancelled" <%= "Cancelled".equals(e.getRemarks()) ? "selected" : ""%>>Cancelled</option>
                            </select>
                        </td>
                        <td>
                            <a href="<%= request.getContextPath()%>/SubstitutionAssignmentServlet?action=delete&substitutionId=<%= e.getSubstitutionId()%>&scheduleId=<%= e.getScheduleId()%>"
                               class="delete-icon" 
                               onclick="return confirm('Do you want to delete this substitution assignment?');">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>

                        <td><%= e.getNotes()%> 
                            <input type="hidden" name="substitutionId" value="<%= e.getSubstitutionId()%>">
                            <input type="hidden" name="scheduleId" value="<%= e.getScheduleId()%>">
                            <input type="hidden" name="status" value="<%= e.getStatus()%>"></td>
                    </tr>
                    <%
                        lastSubstitutionId = e.getSubstitutionId();
                    %>
                    <% }%>
                </table>
                <button type="submit" id="button1" class="btn btn-primary" name="action" value="update">
                    Save Changes
                </button>
                <button type="submit" id="button2" class="btn btn-primary" style="background-color:red;" name="action" value="confirm">
                    Post
                </button>
            </form>
            <button id="button3" class="btn btn-primary" style="background-color:grey;" onclick="window.location.href = 'manageAssignments.jsp'">Others</button>
        </div>
        <footer>
            <%@include file="footer.jsp"%>
        </footer>

    </body>
</html>
