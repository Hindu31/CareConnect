<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin | Manage Patients</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="vendor/fontawesome/css/font-awesome.min.css">
    <style>
        body {
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            font-family: 'Poppins', sans-serif;
            color: #333;
            text-align: center;
        }
        .dashboard-container {
            width: 80%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        .dashboard-title {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .table {
            width: 100%;
        }
    </style>
    <script>
        function deletePatient(name) {
            if (confirm("Are you sure you want to delete " + name + "?")) {
                console.log("Deleting patient:", name);
                fetch("mangptnts.jsp?deleteName=" + encodeURIComponent(name), { method: "GET" })
                .then(response => response.text())
                .then(data => {
                    alert(data.trim()); // Ensure clean alert message
                    if (data.includes("Successfully deleted")) {
                        location.reload();
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("Deletion failed. Check console for details.");
                });


            }
        }
    </script>
</head>
<body>
<%
    String connectionUrl = "jdbc:mysql://localhost:3307/hospital_database";
    String userId = "root";
    String password = "admin";
    Connection connection = null;
    PreparedStatement pstmt = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(connectionUrl, userId, password);

        String deleteName = request.getParameter("deleteName");
        if (deleteName != null && !deleteName.trim().isEmpty()) {
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");

            try {
                String deleteSQL = "DELETE FROM patients_info WHERE name = ?";
                pstmt = connection.prepareStatement(deleteSQL);
                pstmt.setString(1, deleteName);
                int deletedRows = pstmt.executeUpdate();

                if (deletedRows > 0) {
                    out.print("Successfully deleted");
                } else {
                    out.print("Failed to delete patient: " + deleteName);
                }
            } catch (Exception e) {
                out.print("Error deleting patient: " + e.getMessage());
            } finally {
                if (pstmt != null) pstmt.close();
                if (connection != null) connection.close();
            }

            out.flush();
            return;
        }

        Statement statement = connection.createStatement();
        resultSet = statement.executeQuery("SELECT * FROM patients_info");
%>

    <div class="dashboard-container">
        <h1 class="dashboard-title">Admin | Manage Patients</h1>

        <!-- Download CSV Button -->
        <a href="DownloadPatientsServlet" class="download-btn">Download CSV</a>

        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact No</th>
                    <th>Street</th>
                    <th>Locality</th>
                    <th>Aadhar No.</th>
                    <th>State</th>
                    <th>Country</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% while (resultSet.next()) { %>
                <tr>
                    <td><%= resultSet.getString("name") %></td>
                    <td><%= resultSet.getString("email") %></td>
                    <td><%= resultSet.getString("contact_no") %></td>
                    <td><%= resultSet.getString("street") %></td>
                    <td><%= resultSet.getString("locality") %></td>
                    <td><%= resultSet.getString("aadhar") %></td>
                    <td><%= resultSet.getString("state") %></td>
                    <td><%= resultSet.getString("country") %></td>
                    <td>
                        <button class="btn btn-danger" onclick="deletePatient('<%= resultSet.getString("name") %>')">
                            Delete
                        </button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (resultSet != null) resultSet.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (connection != null) connection.close(); } catch (Exception e) {}
    }
%>

<div style="position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); display: flex; gap: 15px;">
    <a href="AdminDashboardServlet" style="text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; border-radius: 8px; font-size: 18px; font-weight: bold; box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;">
        Dashboard
    </a>
    <a href="index.jsp" style="text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; border-radius: 8px; font-size: 18px; font-weight: bold; box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;">
        Home
    </a>
</div>


</body>
</html>
