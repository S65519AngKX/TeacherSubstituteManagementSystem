<%@page import="com.Model.Report"%>
<%@page import="com.Model.Leave"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.Dao.TeacherDao"%>
<%@page import="java.sql.Date"%>
<%@page import="com.Dao.SubstitutionAssignmentDao"%>
<%@page import="com.Model.SubstitutionAssignments"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos+Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/schedule.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Report</title>

        <!-- Custom fonts for this template-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/2.2.2/css/dataTables.dataTables.css" />

        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
        <style>
            #section {
                flex-grow: 1;
                margin: 0px auto;
                padding: 10px;
                width: 100%;
                overflow: auto;
            }
            .navbar-nav .nav-link.active {
                color: white !important;
            }

            #dateForm {
                padding: 1rem 2rem;
                background-color: #ffffff;
                margin: 1rem auto;
                max-width: 100%;

            }

            #dateForm label{
                font-size:12px;
                margin:auto 0% auto 5%;
                font-weight: bold;
            }
            h1{
                font-weight: bold;
            }

            @media (max-width: 500px) {
                #dateForm {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    padding: 1rem;
                    height: fit-content;
                }

                #dateForm label {
                    font-size: 14px;
                    margin-bottom: 5px;
                    text-align: left;
                }

                #dateForm .input-group {
                    width: 80%;
                    margin-bottom: 10px;
                }

                #dateForm .input-group .form-control {
                    width: 60%;
                    margin-bottom: 10px;
                }

                #button2 {
                    width: 100%;
                    padding:10px;
                    margin-top: 10px;
                }
                #rangeSelect {
                    width: 60%;
                    margin-top: 10px;
                }

            }



        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>
        <!-- Page Wrapper -->
        <div id="section">
            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column"  style="padding: 0% 2%;">

                <!-- Main Content -->
                <div id="content" class="d-flex flex-column shadow-lg" style="background-color: lightcyan;
                     padding: 1% 3%;
                     border-radius: 10px;">                    
                    <nav class="navbar navbar-expand navbar-light bg-white  mb-4 static-top shadow" style="padding: 0%;border-radius:15px;">
                        <!-- Topbar Search -->
                        <form id="dateForm" method="GET" action="ReportServlet" style='width:90%;margin:auto;'>
                            <div class="input-group">
                                <label>Start Date:</label>&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="bi bi-calendar"></span>
                                <input type="date" id="startDate" name='startDate' class="form-control" placeholder="Start Date" />
                                <label>End Date:</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="bi bi-calendar"></span>
                                <input type="date" id="endDate" name='endDate' class="form-control" placeholder="End Date" />
                                <select class="form-select" id="rangeSelect" style="margin-left:5%;" onchange="applyQuickRange(this.value)">
                                    <option value="">-- Select Range --</option>
                                    <option value="today">Today</option>
                                    <option value="last7">Last 7 Days</option>
                                    <option value="last30">Last 30 Days</option>
                                    <option value="thisMonth">This Month</option>
                                    <option value="lastMonth">Last Month</option>
                                    <option value="all">Show All</option>
                                </select>
                                <button class="btn btn-primary" type="submit">Search</button>
                            </div>
                        </form>  
                    </nav>
                    <!-- End of Topbar -->


                    <!-- Begin Page Content -->
                    <div class="container-fluid">

                        <!-- Page Heading -->
                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800 fw-bold">Ranking</h1>
                        </div>
                        <!-- Content Row -->
                        <div class="row">
                            <!-- Content Column -->
                            <!-- Project Card Example -->
                            <div class="card shadow col-lg-5 mb-4 mx-auto">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Top 3 Leave Applicants</h6>
                                </div>
                                <div class="card-body">
                                    <%
                                        List<Report> leaveRank = (List<Report>) request.getAttribute("leaveRanking");
                                        for (Report lr : leaveRank) {
                                            int totalLeave = lr.getTotalLeavesByAllTeachers();
                                            int numLeave = lr.getTotalLeaveDays();
                                            int leavePercentage = (int) ((double) numLeave / totalLeave * 100);
                                            System.out.println(totalLeave + " " + numLeave);
                                    %>
                                    <h4 class="small font-weight-bold"><%= TeacherDao.getTeacherNameById(lr.getTeacherId())%><span
                                            class="float-right"><%=lr.getTotalLeaveDays()%></span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-danger" role="progressbar" style="width: <%= leavePercentage%>%"
                                             aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                            <!-- Project Card Example -->
                            <div class="card shadow col-lg-5 mb-4 mx-auto">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">Top 3 Substitute Teacher</h6>
                                </div>
                                <div class="card-body">
                                    <%
                                        List<Report> substitutionRank = (List<Report>) request.getAttribute("substitutionRanking");
                                        for (Report sr : substitutionRank) {
                                            int total = sr.getTotalSubstitute();
                                            int num = sr.getNumSubstitute();
                                            int percentage = (int) ((double) num / total * 100);
                                    %>
                                    <h4 class="small font-weight-bold"><%= TeacherDao.getTeacherNameById(sr.getSubstitutionTeacherId())%><span
                                            class="float-right"><%=sr.getNumSubstitute()%></span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: <%= percentage%>%"
                                             aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                        <!-- Content Row -->
                        <div class="row">
                            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                                <h1 class="h3 mb-0 text-gray-800 fw-bold">Substitution Assignment Report</h1>

                            </div>
                            <!-- Content Column -->
                            <!-- Project Card Example -->
                            <div class="col-xl-6 col-lg-5">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Substitution Assignment Efficiency</h6>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body" style='margin:auto;'>
                                        <div class="chart-pie pt-4 pb-2">
                                            <canvas id="substitutionEfficiency"></canvas>
                                        </div>

                                    </div>
                                </div>
                            </div>                                
                            <div class="col-xl-6 col-lg-5">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Substitution Assignment Analysis</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="assgnTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Teacher Name</th>
                                                        <th>Times Absent</th>
                                                        <th>Class Covered</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        List<Report> assgnList = (List<Report>) request.getAttribute("assgnReport");
                                                        if (assgnList != null) {
                                                            for (Report e : assgnList) {
                                                    %>
                                                    <tr class="editable-row assignment-row">
                                                        <td><%= TeacherDao.getTeacherNameById(e.getTeacherId())%></td>
                                                        <td><%= e.getNumApply()%></td>
                                                        <td><%= e.getNumSubstitute()%></td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                            <h1 class="h3 mb-0 text-gray-800 fw-bold">Leave Report</h1>
                        </div>
                        <div class="row">

                            <!-- Area Chart -->
                            <div class="col-xl-9 col-lg-8">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Leave Analysis</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="leaveTable" width="100%" cellspacing="0">
                                                <thead>
                                                    <tr>
                                                        <th>Teacher Name</th>
                                                        <th>Total Leave</th>
                                                        <th>Total Leave Day</th>
                                                        <th>Approved(%)</th>
                                                        <th>Rejected(%)</th>
                                                        <th>Pending(%)</th>
                                                        <th>Total Approved Leave Days</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        List<Report> leaveList = (List<Report>) request.getAttribute("leaveReport");
                                                        for (Report report : leaveList) {
                                                    %>
                                                    <tr>
                                                        <td><%= report.getTeacherName()%></td>
                                                        <td><%= report.getTotalLeaves()%></td>
                                                        <td><%= report.getTotalLeaveDays()%></td>
                                                        <td><%= String.format("%.2f", report.getApprovedPercentage())%></td>
                                                        <td><%= String.format("%.2f", report.getRejectedPercentage())%></td>
                                                        <td><%= String.format("%.2f", report.getPendingPercentage())%></td>
                                                        <td><%= report.getTotalApprovedLeaveDays()%></td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pie Chart -->
                            <div class="col-xl-3 col-lg-2">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div
                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Distribution of Leave Types</h6>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body" style='margin:auto;'>
                                        <div class="chart-pie pt-0 pb-0">
                                            <canvas id="leaveTypeChart"></canvas>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.container-fluid -->

                    </div>
                    <!-- End of Main Content -->


                </div>
                <!-- End of Content Wrapper -->

            </div>
        </div>


        <script>
            $(document).ready(function () {
                $('#assgnTable').DataTable({
                    "pageLength": 5
                });
                $('#leaveTable').DataTable({
                    "pageLength": 5
                });
            });

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
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                //for leave
                var ctx = document.getElementById('leaveTypeChart').getContext('2d');

                var leaveData = ${leaveTypeJson};

                // Prepare chart data
                var chartData = {
                    labels: leaveData.map(item => item.leaveTypes),
                    datasets: [{
                            label: 'Leave Type Distribution',
                            data: leaveData.map(item => item.leaveTypePercentage),
                            backgroundColor: leaveData.map(item => getRandomColor()),
                            borderWidth: 1
                        }]
                };


                // Create chart
                var leaveTypeChart = new Chart(ctx, {
                    type: 'doughnut',
                    data: chartData,
                    options: {
                        responsive: true,
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        let label = context.label || '';
                                        let value = context.raw || 0;

                                        return label + ": " + value.toFixed(2) + "%";
                                    }
                                }
                            },
                            legend: {
                                position: 'bottom',
                            }
                        }
                    },
                });

                window.updateLeaveTypeChart = function (newData) {
                    leaveTypeChart.data.labels = newData.map(item => item.leaveTypes);
                    leaveTypeChart.data.datasets[0].data = newData.map(item => item.leaveTypePercentage);
                    leaveTypeChart.update();
                };



                //for substitution assignments
                var ctx2 = document.getElementById('substitutionEfficiency').getContext('2d');

                var substitutionData = ${substitutionTypeJson};

                // Prepare chart data
                var chartDataSubstitution = {
                    labels: substitutionData.map(item => item.substitutionTypes),
                    datasets: [{
                            label: 'Substitution Assignment Efficiency',
                            data: substitutionData.map(item => item.substitutionTypePercentage),
                            backgroundColor: substitutionData.map(item =>
                                item.substitutionTypes === 'Cancelled' ? '#e74a3b' : getRandomColor()
                            ),
                            borderWidth: 1
                        }]
                };

                // Create chart
                var substitutionTypeChart = new Chart(ctx2, {
                    type: 'bar',
                    data: chartDataSubstitution,
                    options: {
                        responsive: true,
                        plugins: {
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        let label = context.label || '';
                                        let value = context.raw || 0;

                                        return label + ": " + value.toFixed(2) + "%";
                                    }
                                }
                            },
                            legend: {
                                position: 'top',
                            }
                        }
                    },
                });

                window.updateSubstitutionTypeChart = function (newData) {
                    substitutionTypeChart.data.labels = newData.map(item => item.substitutionTypes);
                    substitutionTypeChart.data.datasets[0].data = newData.map(item => item.substitutionTypePercentage);
                    substitutionTypeChart.update();
                };

                function getRandomColor() {
                    const letters = '0123456789ABCDEF';
                    let color = '#';
                    for (let i = 0; i < 6; i++) {
                        color += letters[Math.floor(Math.random() * 16)];
                    }
                    return color;
                }
            });
        </script>


        <!-- Bootstrap core JavaScript-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/2.2.2/js/dataTables.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="js/sb-admin-2.min.js"></script>


        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>

</html>
