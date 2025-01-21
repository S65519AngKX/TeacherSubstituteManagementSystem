<%@page import="com.Dao.TeacherDao"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos+Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/schedule.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Manage Schedule</title>
        <style>
            #section{
                flex-grow: 1;
                min-height:72vh;
                margin-bottom: 4%;
            }
            .event-display {
                display: none;
                color: #333;
            }

            .input-fields {
                display: none;
            }

            .time-slot-wrapper .event-display {
                display: block !important;
            }

            .time-slot-wrapper .input-fields {
                display: block !important;
            }
            .search-container{
                margin:1%;
                margin-left: 3%;
                font-size:14px;
            }
            #search{
                width:fit-content;
                font-size:12px;
                margin:auto;
                background-color: #1fbfdb;
                color: white;
                border:none;
                box-shadow: 2px 1px 2px black;
                border-radius:3px;
            }
            #search:hover{
                opacity:0.6;
            }
            #searchLabel{
                font-size: 14px;
            }
            .schedule-table td {
                height: auto;
                vertical-align: middle;
                text-align: center;
            }

            .schedule-table input[type="text"] {
                height: 20px;
                font-size: 13px;
                margin: 2px 0;
            }

            .table td{
                padding: 8px !important;
                height: auto !important;
            }
            .table th{
                padding: 5px !important;
                height: auto !important;
            }
            #button{
                padding:5px;
                font-size:13px;
                width:8%;
                margin:5% auto;
                float: right;
                margin-right:2.5%;
                box-shadow: 2px 2px 2px black;
            }

            @media only screen and (max-width: 769px){
                #section{
                    flex-grow: 1;
                    overflow: auto;
                }
            }

        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>
        <div id="section">
            <!-- Search Container -->
            <div class="search-container">
                <label for="search" id="searchLabel">Select Teacher:</label>
                <select id="teacherSelect" name="teacherName">
                    <option value="" selected>Please select a teacher</option>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/substitutemanagement", "root", "admin");
                            PreparedStatement ps = con.prepareStatement("SELECT teacherName FROM teacher");
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                                String teacherName = rs.getString("teacherName");
                    %>
                    <option value="<%= teacherName%>"><%= teacherName%></option>
                    <%
                            }
                            rs.close();
                            ps.close();
                            con.close();
                        } catch (Exception e) {
                            out.println("<option>Error fetching teacher list</option>");
                            e.printStackTrace();
                        }
                    %>
                </select>
                <button id="search" onclick="searchSchedule()"><i class="fa fa-search"></i></button>
            </div>
            <!-- Schedule Table -->
            <form action="<%= (scheduleExists(request.getParameter("teacherName")) ? "UpdateScheduleServlet" : "SaveScheduleServlet")%>" method="POST">
                <div class="schedule-table">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Schedule</th>
                                <th>1<br><span>7:40am - 8:10am</span></th>
                                <th>2<br><span>8:10am - 8:40am</span></th>
                                <th>3<br><span>8:40am - 9:10am</span></th>
                                <th>4<br><span>9:10am - 9:40am</span></th>
                                <th>5<br><span>9:40am - 10:10am</span></th>
                                <th>6<br><span>10:10am - 10:40am</span></th>
                                <th>7<br><span>10:40am - 11:10am</span></th>
                                <th>8<br><span>11:10am - 11:40am</span></th>
                                <th>9<br><span>11:40am - 12:10pm</span></th>
                                <th>10<br><span>12:10pm - 12:40pm</span></th>
                                <th class="last">11<br><span>12:40pm - 1:10pm</span></th>
                            </tr>
                        </thead>
                        <tbody id="schedule-body">
                        <c:set var="teacherId" value="${param.teacherId}" />

                        <%
                            String selectedTeacher = request.getParameter("teacherName");
                            int teacherId = TeacherDao.getTeacherIdByName(selectedTeacher);

                            if (selectedTeacher != null && !selectedTeacher.isEmpty()) {
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/substitutemanagement", "root", "admin");
                                    PreparedStatement ps = con.prepareStatement(
                                            "SELECT scheduleId,scheduleDay, schedulePeriod, scheduleSubject, className "
                                            + "FROM schedule "
                                            + "INNER JOIN teacher ON teacher.teacherId = schedule.teacherId "
                                            + "WHERE teacher.teacherName = ? "
                                            + "ORDER BY FIELD(scheduleDay, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'), schedule.schedulePeriod ASC");
                                    ps.setString(1, selectedTeacher);

                                    ResultSet rs = ps.executeQuery();

                                    String currentDay = "";
                                    if (rs.next()) {
                                        // Existing Schedule found (update schedule)
                                        do {
                                            int scheduleId = rs.getInt("scheduleId");
                                            String day = rs.getString("scheduleDay");
                                            int period = rs.getInt("schedulePeriod");
                                            String subject = rs.getString("scheduleSubject") != null ? rs.getString("scheduleSubject") : " ";
                                            String className = rs.getString("className") != null ? rs.getString("className") : " ";

                                            // Check if the day has changed (to avoid printing the day again)
                                            if (!day.equals(currentDay)) {
                                                out.print("<tr><td class='day'>" + day + "</td>");
                                                currentDay = day;
                                            }

                                            // Render the schedule for the teacher
                                            out.print("<input type='hidden' name='teacherId' value='" + teacherId + "'>");
                                            out.print("<input type='hidden' name='" + day.toLowerCase() + "_" + period + "_scheduleId' value='" + scheduleId + "'>");
                                            out.print("<td><input type='text' name='" + day.toLowerCase() + "_" + period + "_subject' value='" + subject + "' placeholder='Subject' size='5'><br>");
                                            out.print("<input type='text' name='" + day.toLowerCase() + "_" + period + "_class' value='" + className + "' placeholder='Class' size='5'></td>");

                                        } while (rs.next());
                                        out.println("</tr>");
                                    } else {
                                        // No existing schedule found(create schedule)
                                        out.print("<input type='hidden' name='teacherId' value='" + teacherId + "'>");

                                        out.print("<h5 style='margin:0px auto 5px auto;font-weight:bold;text-align:center;'>No schedule found for this teacher. Please fill in the schedule below:</h5>");
                                        //Sunday
                                        out.print("<tr><td class='day'>Sunday</td>");
                                        for (int i = 1; i <= 11; i++) {
                                            out.print("<td><input type='text' name='sunday_" + i + "_subject' placeholder='Subject' size='5'><br><input type='text' name='sunday_" + i + "_class' placeholder='Class' size='5'></td>");
                                        }
                                        out.println("</tr>");

                                        //Monday
                                        out.print("<tr><td class='day'>Monday</td>");
                                        for (int i = 1; i <= 11; i++) {
                                            out.print("<td><input type='text' name='monday_" + i + "_subject' placeholder='Subject' size='5'><br><input type='text' name='monday_" + i + "_class' placeholder='Class' size='5'></td>");
                                        }
                                        out.println("</tr>");

                                        //Tuesday
                                        out.print("<tr><td class='day'>Tuesday</td>");
                                        for (int i = 1; i <= 11; i++) {
                                            out.print("<td><input type='text' name='tuesday_" + i + "_subject' placeholder='Subject' size='5'><br><input type='text' name='tuesday_" + i + "_class' placeholder='Class' size='5'></td>");
                                        }
                                        out.println("</tr>");

                                        //Wednesday
                                        out.print("<tr><td class='day'>Wednesday</td>");
                                        for (int i = 1; i <= 11; i++) {
                                            out.print("<td><input type='text' name='wednesday_" + i + "_subject' placeholder='Subject' size='5'><br><input type='text' name='wednesday_" + i + "_class' placeholder='Class' size='5'></td>");
                                        }
                                        out.println("</tr>");

                                        //Thurday
                                        out.print("<tr><td class='day'>Thursday</td>");
                                        for (int i = 1; i <= 11; i++) {
                                            out.print("<td><input type='text' name='thursday_" + i + "_subject' placeholder='Subject' size='5'><br><input type='text' name='thursday_" + i + "_class' placeholder='Class' size='5'></td>");
                                        }
                                        out.println("</tr>");

                                    }

                                    rs.close();
                                    ps.close();
                                    con.close();
                                } catch (Exception e) {
                                    out.println("<td colspan='12'>Error fetching schedule</td>");
                                    e.printStackTrace();
                                }
                            } else {
                                out.print("<tr><td colspan='12' style='text-align: center; font-weight: bold;font-size:18px;'>Please select a teacher.</td></tr>");
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <button type="submit" id="button1" class="btn btn-primary">Save Schedule</button>
            </form>
            <button id="button2" class="btn btn-primary" style="background-color:red;" onclick="deleteSchedule()">Delete Schedule</button>
            <button id="button3" class="btn btn-primary" style="background-color:grey;" onclick="uploadFile()">Upload File</button>

        </div>
        <footer>
            <%@include file="footer.jsp"%>
        </footer>

        <script>
            function deleteSchedule() {
                const teacherId = document.querySelector("input[name='teacherId']").value;

                if (confirm('Are you sure you want to delete the schedule?')) {
                    window.location.href = 'DeleteScheduleServlet?teacherId=' + teacherId;
                }
            }
            function searchSchedule() {
                const teacherName = document.querySelector("select[name='teacherName']").value;
                if (teacherName) {
                    window.location.href = "SCHEDULES.jsp?teacherName=" + encodeURIComponent(teacherName);
                } else {
                    alert("Please select a teacher.");
                }
            }


            // Function to check if a teacher is selected and show/hide the button
            function checkTeacherNameFromURL() {
                const urlParams = new URLSearchParams(window.location.search);

                if (urlParams.has('teacherName') && urlParams.get('teacherName').trim() !== "") {
                    document.getElementById('button').style.display = 'block';
                    document.getElementById('button2').style.display = 'block';
                    document.getElementById('scheduleContent').style.display = 'block'; // Show schedule content
                } else {
                    // If no teacher is selected, hide the Save button and hide schedule content
                    document.getElementById('button').style.display = 'none';
                    document.getElementById('button2').style.display = 'none';
                    document.getElementById('scheduleContent').style.display = 'none'; // Hide schedule content
                }
            }
            window.onload = function () {
                checkTeacherNameFromURL();
            };
        </script>   
        <%!
            public boolean scheduleExists(String teacherName) {
                boolean exists = false;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/substitutemanagement", "root", "admin");
                    PreparedStatement ps = con.prepareStatement(
                            "SELECT COUNT(*) FROM schedule "
                            + "INNER JOIN teacher ON teacher.teacherId = schedule.teacherId "
                            + "WHERE teacher.teacherName = ?");
                    ps.setString(1, teacherName);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        exists = rs.getInt(1) > 0;
                    }
                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return exists;
            }%>
    </body>
</html>
