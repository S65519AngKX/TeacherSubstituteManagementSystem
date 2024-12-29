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
        <link rel="stylesheet"href="https://fonts.googleapis.com/css?family=Stardos Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/form.css">
        <title>Add Staff</title>  
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <form method="post"action="SaveTeacherServlet">
            <h1 id="title"> Add New Teacher</h1>
            <table style="margin:30px auto;">
                <tr>
                    <td><label for="name">Name: </label></td>
                    <td><input type="text"name="name"required></td>
                </tr>
                <tr>
                    <td><label for="email">Email: </label></td>
                    <td><input type="text"name="email"required></td>
                </tr>
                <tr>
                    <td><label for="contactNo">Contact No:</label></td>
                    <td><input type="text"name="contactNo"required></td>
                </tr>
                <tr>
                    <td><label for="role">Role: </label></td>
                    <td><select name="role"required>
                            <option value="Teacher">Teacher</option>
                            <option value="Principal">Principal</option>
                            <option value="Assistant Principal">Assistant Principal</option>
                        </select></td>
                </tr>
            </table>
            <br><br>
            <div id="formButton">
                <input type="submit"value="Add">
                <input style="background-color: #9da0a1"type="reset"value="Cancel" onclick="return viewTeacher()">
            </div>

        </form>
        <script>
            function viewTeacher() {
                window.location.href = "TEACHERS.jsp";
            }
        </script>
    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

</html>
