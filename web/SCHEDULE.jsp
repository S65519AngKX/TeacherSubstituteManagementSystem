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
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

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
                <tbody>
                    <tr>
                        <td class="day">Sunday</td>
                        <td class="active">
                            <h4>BM</h4>
                            <p>10 am - 11 am</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>BC</h4>
                            <p>03 pm - 04 pm</p>
                        </td>
                        <td class="active">
                            <h4>BM</h4>
                            <p>05 pm - 06 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Music</h4>
                            <p>10 am - 11 am</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>PJ</h4>
                            <p>03 pm - 04 pm</p>
                        </td>
                        <td class="active">
                            <h4>BI</h4>
                            <p>05 pm - 06 pm</p>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="day">Monday</td>
                        <td></td>
                        <td class="active">
                            <h4>SC</h4>
                            <p>11 am - 12 pm</p>
                        </td>
                        <td class="active">
                            <h4>MM</h4>
                            <p>03 pm - 05 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>PM</h4>
                            <p>07 pm - 08 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>ISLAM</h4>
                            <p>11 am - 12 pm</p>
                        </td>
                        <td class="active">
                            <h4>KH</h4>
                            <p>03 pm - 05 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>BI</h4>
                            <p>07 pm - 08 pm</p>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="day">Tuesday</td>
                        <td class="active">
                            <h4>BC</h4>
                            <p>10 am - 11 am</p>
                        </td>
                        <td></td>
                        <td></td>
                        <td class="active">
                            <h4>BC</h4>
                            <p>05 pm - 06 pm</p>
                        </td>
                        <td class="active">
                            <h4>BC</h4>
                            <p>07 pm - 08 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>MUSIC</h4>
                            <p>11 am - 12 pm</p>
                        </td>
                        <td class="active">
                            <h4>PJ</h4>
                            <p>03 pm - 05 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>BM</h4>
                            <p>07 pm - 08 pm</p>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="day">Wednesday</td>
                        <td class="active">
                            <h4>Body Building</h4>
                            <p>10 am - 12 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Dance</h4>
                            <p>03 pm - 05 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Health</h4>
                            <p>07 pm - 08 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Cycling</h4>
                            <p>11 am - 12 pm</p>
                        </td>
                        <td class="active">
                            <h4>Karate</h4>
                            <p>03 pm - 05 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Crossfit</h4>
                            <p>07 pm - 08 pm</p>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="day">Thursday</td>
                        <td></td>
                        <td class="active">
                            <h4>Bootcamp</h4>
                            <p>11 am - 12 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Boday Building</h4>
                            <p>05 pm - 06 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Bootcamp</h4>
                            <p>11 am - 12 pm</p>
                        </td>
                        <td></td>
                        <td class="active">
                            <h4>Boday Building</h4>
                            <p>05 pm - 06 pm</p>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>
</html>



