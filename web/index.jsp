<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
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
                padding: 30px 60px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            }
            .login-card h1 {
                margin-bottom: 20px;
            }
            .login-card a {
                color: rgb(0, 102, 204);
                text-decoration: none;
            }
            .login-card a:hover {
                text-decoration: underline;
            }
            .form-label{
                font-weight:500;
            }
            @media only screen and (max-width: 768px) {
                .text-center{
                        font-size: 10vw;
                }
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="login-card">
                        <h1 class="text-center"id="logo">Smart<span id="logo1">Sub</span></h1>
                        <form action="doLogin.jsp" method="POST">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary">Login</button>
                            </div>
                            <div class="text-center mt-3">
                                <a href="resetPassword.jsp">Forgot Password?</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
