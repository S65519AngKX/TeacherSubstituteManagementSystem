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
                margin: 20px auto;
                padding: 20px;
                max-width: 1200px;
            }

            #div1 {
                background-image: url('images/education.jpg');
                background-size: cover;
                background-position: center;
                height: 420px;
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

        </style>
    </head>

    <body>
        <header>
            <%@ include file="header.jsp" %>
        </header>

        <div class="container" id="section">
            <div id="div1"></div>

            <div class="row text-center mt-5">
                <div class="col-md-4">
                    <div class="feature-box">
                        <i class="fas fa-calendar-check feature-icon"></i>
                        <h4>Efficient Scheduling</h4>
                        <p>Generate substitution schedules automatically and minimize errors.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <i class="fas fa-bullhorn feature-icon"></i>
                        <h4>Streamlined Communication</h4>
                        <p>Notify teachers in real-time about schedule updates and changes.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <i class="fas fa-cogs feature-icon"></i>
                        <h4>Flexible Management</h4>
                        <p>Easily update and modify schedules based on teacher availability.</p>
                    </div>
                </div>
            </div>

            <div id="div2" class="mt-5">
                <fieldset>
                    <legend>How It Works</legend>
                    <p><strong>1. Input:</strong> Admins identify absent teachers and available substitutes via the portal.</p>
                    <p><strong>2. Generate:</strong> The system creates optimized substitution schedules automatically.</p>
                    <p><strong>3. Notify:</strong> Teachers are notified through the portal or email instantly.</p>
                </fieldset>
            </div>
        </div>

        <footer>
            <%@ include file="footer.jsp" %>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
