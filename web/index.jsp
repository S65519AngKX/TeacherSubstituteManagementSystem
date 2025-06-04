<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <style>
            body {
                background-image: url("images/loginBackground.jpg");
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .login-card {
                background-image: radial-gradient(white, rgb(158, 219, 214));
                border-radius: 20px;
                padding: 50px 60px;
                width:35%;
                margin:0 auto;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            }
            .login-card h1 {
                margin-bottom: 20px;
            }
            .login-card a {
                color: rgb(0, 102, 204);
                text-decoration: none;
                font-size:15px
            }
            .login-card a:hover {
                text-decoration: underline;
            }
            .form-label{
                font-weight:bold;
                font-size:18px;
            }
            .form-control{
                font-size:15px;
            }
            #button button{
                font-size: 15px;
                margin-top:15%;
            }
            
            @media only screen and (max-width: 768px) {
                .login-card {
                    padding: 30px 50px;
                    width: 85%;
                    margin: 0 auto;
                }
            }

            @media (min-width: 769px) and (max-width: 991px) {
                .login-card {
                    width: 50%;
                    padding: 40px 55px;
                    margin: 0 auto;
                }
            }

            @media (min-width: 992px) {
                .login-card {
                    width: 40%;
                    padding: 50px 60px;
                    margin: auto;
                }
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="login-card">
                    <h1 class="text-center" id="logo">Smart<span id="logo1">Sub</span></h1>
                    <form action="LoginServlet" method="POST">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <input type="text" id="username" name="username" class="form-control" maxlength="15" placeholder="Enter your username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                        </div>
                        <div class="d-grid" id="button">
                            <button type="submit" class="btn btn-primary" name="action" value="login">Login</button>
                        </div>
                        <div class="text-center mt-3">
                            <a href="resetPassword.jsp">Forgot Password?</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
