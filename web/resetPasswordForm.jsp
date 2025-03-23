<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password Form</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <style>
            @import url(https://fonts.googleapis.com/css?family=Raleway:300,400,600);

            body{
                margin: 0;
                font-size: .9rem;
                font-weight: 400;
                line-height: 1.6;
                color: #212529;
                text-align: left;
                background-color: #f5f8fa;
            }
            .reset-form
            {
                font-family: Raleway, sans-serif;
                padding-top: 1.5rem;
                padding-bottom: 1.5rem;
                margin: 5% auto;
            }
            .card-header{
                font-weight: 700;
                font-size:20px;
            }
            .reset-form .row
            {
                margin-left: 0;
                margin-right: 0;
            }
            .pass_show{
                position: relative
            }
            .pass_show .ptxt {
                position: absolute;
                top: 50%;
                right: 10px;
                z-index: 1;
                color: #f36c01;
                margin-top: -10px;
                cursor: pointer;
                transition: .3s ease all;

            }
            .pass_show .ptxt:hover{
                color: #333333;
            }
            form {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                margin:auto;
                margin-top:10%;
                height: 30vh;
            }
            form label{
                font-weight: bold;
            }
            span{
                color:red;
                font-weight: bold;
                margin-top:10px;
            }
        </style>
    <head>

    <body>
        <div class="reset-form">
            <div class="cotainer">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">Reset Password</div>
                            <div class="card-body">
                                <form action="LoginServlet" method="POST" onsubmit="return validatePasswords()">
                                    <div class="form-group row">
                                        <input type="hidden" id="token" name="token" class="form-control" value="${param.token}"> 
                                        <label>New Password</label>&nbsp;&nbsp;&nbsp;
                                        <div class="form-group pass_show"> 
                                            <input type="password" id="password" name="password" class="form-control" placeholder="New Password"> 
                                        </div> 

                                    </div>

                                    <div class="form-group row">
                                        <label>Confirm Password</label>&nbsp;&nbsp;&nbsp;
                                        <div class="form-group pass_show"> 
                                            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password"> 
                                        </div> 
                                    </div>

                                    <div class="col-md-6 offset-md-4">
                                        <button type="submit" name='action' value='reset' class="btn btn-primary">Confirm</button>
                                    </div>
                                    <span id="errorMsg"></span>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        $(document).ready(function () {
            $('.pass_show').append('<span class="ptxt">Show</span>');
        });

        $(document).on('click', '.pass_show .ptxt', function () {
            $(this).text($(this).text() == "Show" ? "Hide" : "Show");
            $(this).prev().attr('type', function (index, attr) {
                return attr == 'password' ? 'text' : 'password';
            });
        });
        function validatePasswords() {
            const password = document.getElementById("password").value.trim();
            const confirmPassword = document.getElementById("confirmPassword").value.trim();
            const confirmPasswordError = document.getElementById("errorMsg");

            if (password !== confirmPassword) {
                confirmPasswordError.textContent = "Passwords do not match.Please re-enter the password!";
                return false;
            } else {
                confirmPasswordError.textContent = "";
                return true;
            }
        }
    </script>
    <html>
