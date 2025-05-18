<%-- 
    Document   : addStaff
    Created on : May 21, 2024, 11:19:47 PM
    Author     : ACER
--%>

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
        <link rel="stylesheet" href="css/form.css">
        <title>Add Staff</title>  
        <style>
            @media only screen and (max-width: 769px){
                #section{
                    flex-grow: 1;
                    overflow: auto;
                }
            }
        </style>
    </head>



    <body>
        <header>
            <%@include file="header.jsp"%>
        </header>

        <section id="section" class="vh-80 gradient-custom">
            <ul class="breadcrumb">
                <li><a href="HOME.jsp">Home</a></li>
                <li><a href="TEACHERS.jsp">Teachers</a></li>
                <li>Add Teacher</li>
            </ul>
            <div class="container h-60"> 
                <div class="row justify-content-center align-items-center h-60">
                    <div class="col-12 col-lg-9 col-xl-9">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-2 p-md-4">
                                <h3 class="mb-3 pt-3 pb-md-0 mb-md-3"id="title">Add New Teacher</h3>
                                <form method="post" action="TeacherServlet">
                                    <div class="row">
                                        <div class="col-md-6 mb-2">
                                            <div data-mdb-input-init class="form-outline">
                                                <label class="form-label" for="name">Name:</label>
                                                <input type="text" name="name" class="form-control form-control-lg" maxlength="50" required/>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-2">
                                            <div data-mdb-input-init class="form-outline">
                                                <label class="form-label" for="telegramId">Chat ID(Telegram):</label>
                                                <input type="text" name="telegramId" class="form-control form-control-lg"  maxlength="10" placeholder="eg. 1234567890" pattern="[0-9]{10}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4 mb-2 d-flex align-items-center">
                                            <div data-mdb-input-init class="form-outline">
                                                <label for="email" class="form-label">Email</label>
                                                <input type="email" name="email" id="email" class="form-control form-control-lg"  maxlength="50" required />
                                            </div>
                                        </div>
                                        <div class="col-md-4 mb-2 d-flex align-items-center">
                                            <div data-mdb-input-init class="form-outline">
                                                <label for="contact" class="form-label">Contact:</label>
                                                <input type="tel" name="contactNo" id="contact" class="form-control form-control-lg" maxlength="15" placeholder="eg. 012-3456789" pattern="01[0-9]-[0-9]{7,8}" required />
                                            </div>
                                        </div>
                                        <div class="col-md-4 mb-2 d-flex align-items-center">
                                            <div data-mdb-input-init class="form-outline">
                                                <label for="role" class="form-label">Role</label>
                                                <select name="role" id="role" class="select form-control-lg" required>
                                                    <option value="Teacher">Teacher</option>
                                                    <option value="Principal">Principal</option>
                                                    <option value="Assistant Principal">Assistant Principal</option>
                                                    <option value="Part Time">Assistant Principal</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="container d-flex justify-content-center align-items-center">
                                        <div class="row col-md-10 d-flex align-items-center" style="background: linear-gradient(to bottom right, #ffffff 0%, #ccffff 100%); border-radius: 10px; box-shadow: 2px 2px 2px black; padding: 20px;">
                                            <div class="col-md-6 mb-1">
                                                <label for="username" class="form-label">Username:</label>
                                                <input type="text" name="username" class="form-control"  maxlength="15" required>
                                            </div>
                                            <div class="col-md-6 mb-1">
                                                <label for="password" class="form-label">Password:</label>
                                                <input type="password" name="password" class="form-control" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-0 pt-2">
                                        <div id="formButton">
                                            <input style="background-color: #9da0a1" type="reset" value="Cancel" onclick="return viewTeacher()">
                                            <button type="submit" id='button' name='action' value="save">Add</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script>
            function viewTeacher() {
                window.location.href = "TEACHERS.jsp";
            }
        </script>
        <footer>
            <%@ include file="footer.jsp" %>
        </footer>
    </body>



</html>
