<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos+Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Teacher Substitution Management System</title>
        <style>
            #section {
                flex-grow: 1;
                margin: 0px auto;
                padding: 20px;
                max-width: 100%;
                overflow: auto;
            }

            #div1 {
                background-image: url('images/education.jpg');
                background-size: cover;
                background-position: center;
                width: 80%;
                height:280px;
                margin: 0 auto;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            #div2 {
                margin-top: 20px;
            }

            .mt-5 *{
                font-size: 20px;
            }
            .mt-5 legend{
                font-size:30px;
                font-weight: bold;
            }
            #div2,#div-3{
                width:80%;
                margin:auto;
            }

            #div2 fieldset {
                border: none;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 20px;
                background: linear-gradient(to top, #00ccff 0%, #ccffff 100%);
                color: black;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

            legend {
                font-weight: bold;
                color: black;
                text-shadow: 2px 2px #007bff;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .feature-box {
                text-align: center;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
                background-color: white;
                transition: transform 0.3s ease;
            }

            .feature-box:hover {
                transform: scale(1.05);
            }

            .feature-icon {
                font-size: 40px;
                color: #007bff;
                margin-bottom: 10px;
            }
            .col-md-4 {
                text-decoration: none;
                color:black;

            }
            .col-md-4 h4{
                font-weight: bold;
            }
            @media (min-width: 480px) and (max-width: 767px){
                .mt-5 *{
                    font-size: 18px;
                }
                .mt-5 legend{
                    font-size:23px;
                }
            }

        </style>
    </head>

    <body>
        <header>
            <%@ include file="header.jsp" %>
        </header>

        <div id="section">
            <div id="div1"></div>

            <div class="row text-center mt-5" id="div-3">
                <a class="col-md-4" href="LEAVE.jsp">
                    <div class="feature-box">
                        <i class="fas fa-calendar-check feature-icon"></i>
                        <h4>Apply Leave</h4>
                        <p>Easily submit leave requests through the system, ensuring smooth tracking for approvals.</p>
                    </div>
                </a>
                <a class="col-md-4" href="SCHEDULE.jsp">
                    <div class="feature-box">
                        <i class="fas fa-bullhorn feature-icon"></i>
                        <h4>View Schedule</h4>
                        <p>Access your teaching schedule in real-time to stay updated on class timings and assignments.</p>
                    </div>
                </a>
                <a class="col-md-4" href="SUBSTITUTION.jsp">
                    <div class="feature-box">
                        <i class="fas fa-cogs feature-icon"></i>
                        <h4>View Substitution Assignments</h4>
                        <p>Quickly check and manage your assigned substitution tasks to ensure seamless class coverage.</p>
                    </div>
                </a>
            </div>

            <div id="div2" class="mt-5">
                <fieldset>
                    <legend>How It Works</legend>
                    <p><strong>1. Input:</strong> Assistant principal identify absent teachers and available substitutes via the portal.</p>
                    <p><strong>2. Generate:</strong> The system creates optimized substitution schedules automatically.</p>
                    <p><strong>3. Notify:</strong> Teachers are notified through the portal or Telegram instantly.</p>
                </fieldset>
            </div>
        </div>

        <footer>
            <%@ include file="footer.jsp" %>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
