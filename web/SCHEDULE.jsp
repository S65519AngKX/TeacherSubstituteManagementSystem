<%@page import="util.Database"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/schedule.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Schedule</title>
        <style>
            #section{
                flex-grow: 1;
                min-height:72vh;
                margin-bottom: 1%;
            }
            .schedule-table{
                min-height: 75vh;
            }
            .table td{
                padding: 15px !important;
                height: auto !important;
            }
            .table th{
                padding: 10px !important;
                height: auto !important;
            }
            
        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <div id="section" class="schedule-table">
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
                    <%
                        int selectedTeacher = Integer.parseInt(session.getAttribute("teacherId").toString());
                        try {
                            Connection con = Database.getConnection();
                            PreparedStatement ps = con.prepareStatement(
                                    "SELECT scheduleDay, schedulePeriod, scheduleSubject, className FROM schedule WHERE teacherId = ? ORDER BY FIELD(scheduleDay, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'),schedulePeriod ASC");
                            ps.setInt(1, selectedTeacher);

                            ResultSet rs = ps.executeQuery();

                            String currentDay = "";
                            if (rs.next()) {
                                // Existing Schedule found (update schedule)
                                do {
                                    String day = rs.getString("scheduleDay");
                                    String subject = rs.getString("scheduleSubject") != null ? rs.getString("scheduleSubject") : " ";
                                    String className = rs.getString("className") != null ? rs.getString("className") : " ";

                                    // Check if the day has changed (to avoid printing the day again)
                                    if (!day.equals(currentDay)) {
                                        out.print("<tr><td class='day'>" + day + "</td>");
                                        currentDay = day;
                                    }

                                    // Render the schedule for the teacher
                                    out.print("<td style='text-align:center'><h4 style='font-weight:bold;margin:0'>" + subject + "</h4><p style='font-size:1.1em;color:#636161;margin:0'>" + className + "</p></td>");

                                } while (rs.next());
                                out.println("</tr>");
                            } else {
                                // No existing schedule found
                                out.print("<tr><td colspan='12' style='text-align: center; font-weight: bold;font-size:18px;'>No schedule found for this teacher</td></tr>");
                            }
                            rs.close();
                            ps.close();
                            con.close();
                        } catch (Exception e) {
                            out.println("<td colspan='12'>Error fetching schedule</td>");
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>
</html>
