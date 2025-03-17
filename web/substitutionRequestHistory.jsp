<%-- 
    Document   : substitutionRequestHistory
    Created on : Mar 12, 2025, 11:08:25 PM
    Author     : Khe Xin
--%>

<%@page import="com.Dao.SubstitutionRequestPeriodDao"%>
<%@page import="com.Model.SubstitutionRequestPeriod"%>
<%@page import="com.Model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.Model.SubstitutionRequest"%>
<%@page import="com.Dao.SubstitutionRequestDao"%>
<%@page import="com.Dao.TeacherDao"%>  

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Stardos+Stencil">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/list.css">
        <title>Substitution Request History</title>
        <style>
            #title{
                font-size: 30px;
            }
            
            table tr td,th{
                text-align:  center;
            }

        </style>
    </head>

    <header>
        <%@include file="header.jsp"%>
    </header>

    <body>
        <div id="section">
            <h1 id="title">Substitution Request History</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Date</th>
                    <th>Period</th>
                    <th>Reason</th>
                    <th>Notes</th>
                </tr>
                <%
                    String teacherIdStr = (String) session.getAttribute("teacherId");
                    List<SubstitutionRequest> list = SubstitutionRequestDao.getSubstitutionRequestByTeacherId(Integer.parseInt(teacherIdStr));
                    for (SubstitutionRequest e : list) {
                %>
                <tr>
                    <td><%= e.getSubstitutionRequestId()%></td>
                    <td><%= e.getSubstitutionRequestDate()%></td>
                    <td>
                    <%
                        List<SubstitutionRequestPeriod> periods = SubstitutionRequestPeriodDao.getSubstitutionRequestPeriod(e.getSubstitutionRequestId());
                        for (SubstitutionRequestPeriod p : periods) {%>
                        <%= p.getSubstitutionRequestPeriod()%>&nbsp;
                    <%}%></td>
                    <td><%= e.getSubstitutionRequestReason()%></td>
                    <td><%= e.getSubstitutionRequestNotes()%></td>
                </tr>
                <%
                    }
                %>
            </table>
            <button id="button" type="button" onclick="window.location.href = 'requestSubstitution.jsp';">BACK</button>
        </div>
    </body>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>

</html>
