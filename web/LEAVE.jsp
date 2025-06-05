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
            #top{
                display: flex;
                align-items: center;
            }
            #title{
                font-size:30px;
                margin-left:40%;
            }

            #history{
                font-size:13px;
            }

            #button,#history{
                background-color: #1fbfdb;
                color:white;
                border: 0px;
                border-radius:10px;
                padding:5px 15px;
                font-size:15px;
                width:fit-content;
                height:fit-content;
                box-shadow: 2px 2px 2px black;
                align-items: center;
                margin: 2% auto;
            }
            #button:hover, #history:hover{
                opacity:0.8;
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
                    font-size:23px;
                }
                #formButton #history{
                    font-size:11px;
                }
            }

        </style>
    </head>

    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <div id="section" class="container mt-3 mb-0">
            <div class="container h-60"> 
                <div class="row justify-content-center align-items-center h-60">
                    <div class="col-12 col-lg-11 col-xl-11">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-2 p-md-4">
                                <form method="post" action="LeaveServlet" id="applyLeaveForm">
                                    <div id="top">
                                        <h1 id="title">Apply Leave</h1>
                                        <div  id="formButton" class="d-flex justify-content-end mb-2">
                                            <input id="history" type="button" style="background-color:#8d9394;" value="History" onclick="window.location.href = 'teacherLeaveHistory.jsp'"> 
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 mb-0">
                                            <input type="hidden" name="teacherId" value="<%=session.getAttribute("teacherId")%>">
                                        </div>

                                        <div class="col-md-6 mb-2">
                                            <label for="leaveStartDate" class="form-label">Leave Start Date:</label>
                                            <input type="date" id="leaveStartDate" name="leaveStartDate" class="form-control" required>
                                        </div>

                                        <div class="col-md-6 mb-2">
                                            <label for="leaveEndDate" class="form-label">Leave End Date:</label>
                                            <input type="date" id="leaveEndDate" name="leaveEndDate" class="form-control" required>
                                        </div>

                                        <div class="col-12 mb-2">
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

                                        <div class="col-12 mb-2">
                                            <label for="leaveNotes" class="form-label">Notes:</label>
                                            <textarea name="leaveNotes" class="form-control" placeholder="Please enter your special requests for substitution assignments" maxlength="200" rows="4"></textarea>
                                        </div>

                                        <!--Assign default status for leave-->
                                        <input type="hidden" id="leaveStatus" name="leaveStatus" value="Pending">

                                        <div id="formButton">
                                            <button type="submit" id='button' name="action" value="save">Apply</button>
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
            document.addEventListener('DOMContentLoaded', function () {
                const startDateInput = document.getElementById('leaveStartDate');
                const endDateInput = document.getElementById('leaveEndDate');

                function disableWeekends(input) {
                    input.addEventListener('input', function () {
                        const selectedDate = new Date(this.value);
                        const day = selectedDate.getDay(); // 5 = Friday, 6 = Saturday

                        if (day === 5 || day === 6) {
                            alert('Fridays and Saturdays are not allowed. Please select another date.');
                            this.value = ''; // Clear invalid date
                        }
                    });
                }

                disableWeekends(startDateInput);
                disableWeekends(endDateInput);
            });

        </script>

        <footer>
            <%@ include file="footer.jsp" %>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
