<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>S.U.C.C.E.S.S</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%
String dname=request.getParameter("dname");
	String apdate=request.getParameter("date");
	String time=request.getParameter("time");
	String dspec=request.getParameter("dspec");
	String pname=request.getParameter("pname");
	String apstatus="Waiting";
	String solution="";
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/hospital_database","root","admin"); 
Statement st= con.createStatement(); 
st.executeUpdate("insert into apn_info values ('"+pname+"','"+dname+"','"+dspec+"','"+apdate+"','"+time+"','"+apstatus+"','"+solution+"')"); 
%>
<br><br>
<b><center>Success</center></b><br>
<center><a href="UserDashboardServlet?uname=<%= pname %>">Back</a></center><br>
<center><a href="/hospital">Home</a></center><br>

</body>
</html>