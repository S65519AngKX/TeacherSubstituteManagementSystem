<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet"href="https://fonts.googleapis.com/css?family=Stardos Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/form.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Manage Profile</title>
        <style>
            table{
                margin: auto;
            }
            table tr td{
                font-size:17px;
            }
            label{
                font-size:17px;
            }
            #formButton input{
                font-size:17px;
            }
            #title{
                font-size:30px;
            }
        </style>
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <h1 id="title"> Manage Profile</h1>

        <form method="post" action="manageProfile">            
            <table>
                <tr>
                    <td><label for="staff_id">Teacher ID: </label></td>
                    <td><input type="text" name="teacherId" value="<%= session.getAttribute("teacherId")%>" readonly></td>                
                </tr>
                <tr>
                    <td><label for="name">Name: </label></td>
                    <td><input type="text" name="name" value="<%= session.getAttribute("name")%>"></td>
                </tr>
                <tr>
                    <td><label for="email">Email: </label></td>
                    <td><input type="text" name="email" value="<%= session.getAttribute("email")%>"></td>
                </tr>
                <tr>
                    <td><label for="contact">Contact No:</label></td>
                    <td><input type="text" name="contactNo" value="<%= session.getAttribute("contact")%>"></td>
                </tr>       
                <tr>
                    <td><label for="role">Role:</label></td>
                    <td><input type="text" name="role" value="<%= session.getAttribute("role")%>" readonly></td>                
                </tr>       
                <tr>
                    <td><label for="username">Username: </label></td>
                    <td><input type="text" name="username" value="<%= session.getAttribute("username")%>" readonly></td>                
                </tr>
                <tr>
                    <td><label for="password">Password: </label></td>
                    <td>
                        <input type="password" name="password" value="<%= session.getAttribute("password")%>">
                        <i class="fas fa-eye" style="color:#1fb1c4;" onclick="togglePasswordVisibility(this)"></i>
                    </td>
                </tr>
            </table>
            <br><br>
            <div id="formButton">
                <input type="submit" value="Submit">
                <input style="background-color: #9da0a1" type="reset" value="Cancel" onclick="return goToHome()">
            </div>
        </form>
        <script>
            function goToHome() {
                window.location.href = "HOME.jsp";
            }

            function togglePasswordVisibility(icon) {
                var passwordField = icon.previousElementSibling;
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.className = "fas fa-eye-slash";
                } else {
                    passwordField.type = "password";
                    icon.className = "fas fa-eye";
                }
            }


        </script>
    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

</html>