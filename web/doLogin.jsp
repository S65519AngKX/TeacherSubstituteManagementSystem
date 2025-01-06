<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/substitutemanagement", "root", "admin");

            PreparedStatement staffPS = con.prepareStatement("SELECT * FROM user WHERE username=? AND password=?");
            staffPS.setString(1, username);
            staffPS.setString(2, password);
            ResultSet teacherRS = staffPS.executeQuery();

            if (teacherRS.next()) {
                String teacherId = teacherRS.getString("teacherId");

                PreparedStatement teacherPS = con.prepareStatement("SELECT * FROM teacher WHERE teacherId=?");
                teacherPS.setString(1, teacherId);
                ResultSet nameRS = teacherPS.executeQuery();

                if (nameRS.next()) {
                    String teacherName = nameRS.getString("teacherName");
                    String teacherEmail = nameRS.getString("teacherEmail");
                    String teacherContact = nameRS.getString("teacherContact");
                    String teacherRole = nameRS.getString("teacherRole");
                    session.setAttribute("teacherId", teacherId);
                    session.setAttribute("name", teacherName);  
                    session.setAttribute("email", teacherEmail);  
                    session.setAttribute("contact", teacherContact);  
                    session.setAttribute("role", teacherRole);  
                    session.setAttribute("username", username);  
                    session.setAttribute("password", password);  

                    response.sendRedirect("HOME.jsp");
                } else {
                    out.println("<script>alert('Teacher name not found.'); window.location.href='index.jsp';</script>");
                }
            } else {
                out.println("<script>alert('Invalid username or password.'); window.location.href='index.jsp';</script>");
            }
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<script>alert(\"Invalid username or password.\"); window.location.href='index.jsp';</script>");
        }
    %>
</body>
</html>
