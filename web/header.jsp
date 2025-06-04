<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

        <link href="https://fonts.googleapis.com/css2?family=Stardos+Stencil&display=swap" rel="stylesheet">
        <title>Header</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: Arial, Helvetica, sans-serif;
                background-color: #95e8f5;
            }

            header {
                width: 100%;
                background-color: #1fb1c4;
                color: white;
                display: flex;
                align-items: center;
                z-index: 1000;
            }

            header .container {
                display: flex;
                align-items: center;
                padding-left: 0 !important;
                padding-right: 0 !important;
            }

            #logo {
                font-family: 'Stardos Stencil', sans-serif;
                font-size: 18px;
                font-weight: bolder;
                color: red;
            }

            #logo1 {
                font-size: 18px;
                font-weight: bolder;
                color: blue;
            }

            .navbar-nav .nav-link {
                font-weight: bold;
                font-size: 14px;
                padding: 5px;
                margin: 0 15px;
            }

            .navbar-nav .nav-link:hover {
                background-color: #7de0e8;
                border-radius: 5px;
            }
            .navbar-nav .nav-link.active {
                color:white;
            }

            .dropdown {
                text-align: center;
                position: relative;
            }

            .dropdown .dropbtn {
                border: none;
                outline: none;
                color: white;
                padding: 0px 20px;
                background-color: inherit;
                font-family: inherit;
                cursor: pointer;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
                z-index: 1;
                right: 0;
                min-width: 150px;
                border-radius: 5px;
            }

            .dropdown-content a {
                float: none;
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                text-align: left;
            }

            .dropdown-content a:hover {
                background-color: #91ccf9;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .main-content {
                flex-grow: 1;
            }

           
            @media (max-width: 768px) {
                header {
                    flex-direction: column;
                    padding: 5px 10px !important; 
                }

                .navbar {
                    padding-top: 0 !important;
                    padding-bottom: 0 !important;
                }

                .navbar-brand {
                    padding: 0 !important;
                    margin: 0 auto !important;
                }

                .navbar-collapse {
                    margin-top: 0 !important;
                }

                .dropdown {
                    margin-top: 5px; /* adjust as needed */
                }
            }

        </style>
    </head>

    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                    <a class="navbar-brand">
                        <div id="logo"><span id="logo1">Smart</span>Sub</div>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav" id="nav-list">
                        </ul>
                        <div id="profile" class="dropdown">
                            <button class="dropbtn"><i class="far fa-user-circle fa-lg"></i><span><%= session.getAttribute("name")%></span></button>
                            <div class="dropdown-content">
                                <a href="manageProfile.jsp">Manage Profile</a>
                                <%
                                    String tempRole = (String) session.getAttribute("tempRole");
                                    String currentRole = (String) session.getAttribute("role");
                                %>
                                <% if ("Teacher".equals(tempRole)) {%>
                                <a href="<%= request.getContextPath()%>/TeacherServlet?action=exitRole" onclick="return confirm('Exit Teacher Mode?')">Exit Teacher Mode</a>
                                <% } else if ("Principal".equals(currentRole) || "Assistant Principal".equals(currentRole)) {%>
                                <a href="<%= request.getContextPath()%>/TeacherServlet?action=switchRole" onclick="return confirm('Switch to Teacher Mode?')">Switch to Teacher Mode</a>
                                <% }%>
                                <a href="index.jsp">Logout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <script>
            var userRole = '<%= session.getAttribute("tempRole") != null ? session.getAttribute("tempRole") : session.getAttribute("role")%>';
            var navItems = {
                'Principal': ['HOME', 'LEAVES', 'REPORT'],
                'Assistant Principal': ['HOME', 'TEACHERS', 'SCHEDULES', 'SUBSTITUTIONS', 'REPORT'],
                'Teacher': ['HOME', 'LEAVE', 'SCHEDULE', 'SUBSTITUTION'],
                'Part Time': ['HOME', 'LEAVE', 'SCHEDULE', 'SUBSTITUTION']
            };

            var navList = document.getElementById('nav-list');
            var currentPage = window.location.pathname.split('/').pop(); // Get the current page file name 

            navItems[userRole].forEach(function (item) {
                var li = document.createElement('li');
                li.classList.add('nav-item');
                var page = item + '.jsp';
                var comparePage = item;

                if (item === 'REPORT') {
                    page = '<%= request.getContextPath()%>/ReportServlet';
                    comparePage = 'ReportServlet';
                }

                var isActive = currentPage.toUpperCase().includes(comparePage.toUpperCase());
                li.innerHTML = '<a class="nav-link' + (isActive ? ' active' : '') + '" href="' + page + '">' + item + '</a>';
                navList.appendChild(li);

            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>

</html>
