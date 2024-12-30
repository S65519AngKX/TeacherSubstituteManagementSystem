<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Stardos+Stencil" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/form.css">
        <title>Apply Leave</title>
        <style>
            #title{
                font-size:30px;
            }
            form{
                margin-top:0;
            }
            #formButton #history{
                font-size:13px;
            }

        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <div class="container mt-5">
            <div  id="formButton" class="d-flex justify-content-end mb-3">
                <input id="history" type="button" style="background-color:#8d9394;" value="History" onclick="window.location.href = 'teacherLeaveHistory.jsp'"> 
            </div>
            <form method="post" action="SaveLeaveServlet" id="applyLeaveForm">
                <h1 id="title">Apply Leave</h1>
                <div class="row">
                    <div class="col-12">
                        <input type="hidden" name="teacherId" value="<%=session.getAttribute("teacherId")%>">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="leaveStartDate" class="form-label">Leave Start Date:</label>
                        <input type="date" id="leaveStartDate" name="leaveStartDate" class="form-control" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="leaveEndDate" class="form-label">Leave End Date:</label>
                        <input type="date" id="leaveEndDate" name="leaveEndDate" class="form-control" required>
                    </div>

                    <div class="col-12 mb-3">
                        <label for="leaveReason" class="form-label">Leave Reason:</label>
                        <select name="leaveReason" class="form-select" required>
                            <option value="">Select a Reason</option>
                            <option value="Medical Leave">Medical Leave</option>
                            <option value="Special Leave">Special Leave</option>
                            <option value="Annual Leave">Annual Leave</option>
                            <option value="Event Leave">Event Leave</option>
                            <option value="Development Leave">Development Leave</option>
                        </select>
                    </div>

                    <div class="col-12 mb-3">
                        <label for="leaveNotes" class="form-label">Notes:</label>
                        <textarea name="leaveNotes" class="form-control" rows="4"></textarea>
                    </div>

                    <!--Assign default status for leave-->
                    <input type="hidden" id="leaveStatus" name="leaveStatus" value="Pending">

                    <div id="formButton">
                        <input type="submit" value="Apply">
                    </div>
                </div>
            </form>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const startDateInput = document.getElementById('leaveStartDate');
                const endDateInput = document.getElementById('leaveEndDate');

                document.getElementById('applyLeaveForm').addEventListener('submit', function (event) {
                    const startDateValue = new Date(startDateInput.value);
                    const endDateValue = new Date(endDateInput.value);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);
                    startDateValue.setHours(0, 0, 0, 0);


                    if (startDateValue < today) {
                        alert('Leave Start Date must be today or later');
                        event.preventDefault();
                    }

                    if (endDateValue <= startDateValue) {
                        alert('Leave End Date must be later than the Leave Start Date');
                        event.preventDefault();
                    }
                });
            });
        </script>

        <footer>
            <%@ include file="footer.jsp" %>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
