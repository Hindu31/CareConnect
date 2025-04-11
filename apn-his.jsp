<!DOCTYPE html>
<html lang="en">
<head>
    <title>Appointments</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="http://fonts.googleapis.com/css?family=Poppins:300,400,600,700" rel="stylesheet" type="text/css" />
    <style>
        body {
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            font-family: 'Poppins', sans-serif;
            color: #333;
            text-align: center;
        }
        .container-fullw {
            width: 80%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        .mainTitle {
            font-size: 24px;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #5B86E5;
            color: white;
        }
        .btn-success {
            background-color: #36D1DC;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0px 10px 15px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>


<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String driverName = "com.mysql.cj.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "hospital_database";
String userId = "root";
String password = "admin";

// Disable SSL by setting useSSL=false
String url = connectionUrl + dbName + "?useSSL=false";

String sql = null;

try {
    Class.forName(driverName);
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}
int id = Integer.parseInt(request.getParameter("id"));
String a = null;
if (id == 1) { 
    sql = "SELECT * FROM apn_info where apstatus='Waiting' ";
} else if (id == 2) {
    String name = (String) session.getAttribute("doctorUser");
    String n=name;
    sql = "SELECT * FROM apn_info where dname='" + name + "' "+"and ( solution IS NULL or solution = '')and apstatus='Approved'" ;
} else {
    String name = request.getParameter("pname");
    a = " where pname='" + name + "'";
    sql = "SELECT * FROM apn_info " + a;
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<div id="app">      
    <div class="app-content">
        <div class="main-content" >
            <div class="wrap-content container" id="container">
                <section id="page-title">
                    <div class="row">
                        <div class="col-sm-8">
                            <h1 class="mainTitle">Manage Appointments</h1>
                        </div>
                    </div>
                </section>
                <div class="container-fluid container-fullw bg-white">
                    <div class="row">
                        <div class="col-md-12">
                            <h5 class="over-title margin-bottom-15">Appointments <span class="text-bold">History</span></h5>
                            <p style="color:red;">
                            <table class="table table-hover" id="sample-table-1">
                                <thead>
                                    <tr>
                                        <th><b>Patient Name</b></th>               
                                        <th><b>Doctor Name</b></th>
                                        <th><b>Specialization</b></th>   
                                        <th><b>Date</b></th>    
                                        <th><b>Time</b></th> 
                                        <% if(id==1){%>
                                    	<th><b>Approval</b> 
                                    	<%} %>
                                    	<% if(id==2){%>
                                    	<th><b>Solution</b> 
                                    	<%} %>
                                    	<% if(id!=2 && id!=1){%>
                                    	<th><b>Appontment Status</b> 
                                    	<%} %>
                                    </tr>
                                <%
                                try { 
                                    connection = DriverManager.getConnection(url, userId, password);
                                    statement = connection.createStatement();
                                    resultSet = statement.executeQuery(sql);
                                    while (resultSet.next()) {
                                %>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><%=resultSet.getString("pname") %></td>
                                    <td><%=resultSet.getString("dname") %></td>
                                    <td><%=resultSet.getString("spec") %></td>
                                    <td><%=resultSet.getString("apdate") %></td>
                                    <td><%=resultSet.getString("aptime") %></td>
                                    <%if(id==1){ %>
                                    <td>
    								<form action="approve_appointment.jsp" method="POST">
        							<input type="hidden" name="pname" value="<%=resultSet.getString("pname") %>">
        							<button type="submit" class="btn btn-success">Approve</button>
    								</form>
									</td><%} %>
                                    <% if(id == 2) { %>
                                    <td>
    									<form action="writeSolution.jsp?dname=<%= resultSet.getString("dname") %>" method="GET">
<input type="hidden" name="pname" value="<%=resultSet.getString("pname") %>">
        								<button type="submit" class="btn btn-success">Write Solution</button>
    									</form>
    									</td>
									<% } %>
                                    <% if(id!=2 && id!=1) {%>
                                    <td><%=resultSet.getString("apstatus") %></td>
                                    	<%} %>
                                </tr>
                                
                                <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%if(id==1){ %>
                                   <div style="position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); display: flex; gap: 15px;">
    <a href="AdminDashboardServlet" style="text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; border-radius: 8px; font-size: 18px; font-weight: bold; box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;">
        Dashboard
    </a>
    <a href="index.jsp" style="text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; border-radius: 8px; font-size: 18px; font-weight: bold; box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;">
        Home
    </a>
</div><%} %>
<%if(id==2){ %>
                                   <div style="position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); display: flex; gap: 15px;">
    <a href="DoctorDashboardServlet?uname=<%=(String) session.getAttribute("doctorUser")%>" style="text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; border-radius: 8px; font-size: 18px; font-weight: bold; box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;">
        Dashboard
    </a>
    <a href="index.jsp" style="text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; border-radius: 8px; font-size: 18px; font-weight: bold; box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;">
        Home
    </a>
</div><%} %>
<%if(id!=2 && id!=1) { %>
                                <div style="position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); display: flex; gap: 15px;">
    
    <a href="index.jsp" style="text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; border-radius: 8px; font-size: 18px; font-weight: bold; box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;">
        Home
    </a>
</div><%} %>
</body>
</html>
