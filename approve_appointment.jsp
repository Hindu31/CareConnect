<%@page import="java.sql.*"%>
<%
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3307/";
String dbName = "hospital_database";
String userId = "root";
String password = "admin";

String url = connectionUrl + dbName + "?useSSL=false";
String pname = request.getParameter("pname");
String message = request.getParameter("message");
Connection connection = null;
PreparedStatement preparedStatement = null;

if (pname != null) {
    try {
        Class.forName(driverName);
        connection = DriverManager.getConnection(url, userId, password);
        
        String updateQuery = "UPDATE apn_info SET apstatus='Approved' WHERE pname=?";
        preparedStatement = connection.prepareStatement(updateQuery);
        preparedStatement.setString(1, pname);
        
        int rowsUpdated = preparedStatement.executeUpdate();
        connection.close();

        // Redirect with a success/failure message to prevent re-execution on refresh
        if (rowsUpdated > 0) {
            response.sendRedirect("approve_appointment.jsp?message=success");
        } else {
            response.sendRedirect("approve_appointment.jsp?message=error");
        }

        return; // Stop further execution
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("approve_appointment.jsp?message=error");
        return;
    }
}

// Show alert message only once
if ("success".equals(message)) {
%>
    <script>alert("Appointment Approved Successfully!");
    window.location.href="apn-his.jsp?id=1";</script>
<%
} else if ("error".equals(message)) {
%>
    <script>alert("Error Approving Appointment.");
    window.location.href="approve_appointment.jsp"; </script>
<%
}
%>
