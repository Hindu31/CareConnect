<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin | Manage Doctors</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            width: 50%;
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
        .hidden-form {
            display: none;
            margin-top: 20px;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            text-align: center;
            background: white;
        }
        th, td {
            padding: 15px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tbody tr:hover {
            background-color: #f1f1f1;
        }
    </style>
    <script>
        function toggleForm() {
            var form = document.getElementById("addDoctorForm");
            if (form.style.display === "none") {
                form.style.display = "block";
            } else {
                form.style.display = "none";
            }
        }
    </script>
</head>
<body>
    <div class="dashboard-container">
        <h2 class="dashboard-title">Manage Doctors</h2>
        <button class="btn btn-primary" onclick="toggleForm()">Add Doctor</button>
        
        <div id="addDoctorForm" class="hidden-form">
            <form method="POST">
                <input type="text" name="dname" class="form-control" placeholder="Doctor Name" required><br>
                <input type="text" name="dspec" class="form-control" placeholder="Specialization" required><br>
                <input type="password" name="psswd" class="form-control" placeholder="Password" required><br>
                <button type="submit" class="btn btn-success">Save Doctor</button>
            </form>
        </div>
        
        <%@page import="java.sql.*" %>
        <%
            String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
            String DB_USER = "root";
            String DB_PASSWORD = "root";
            Connection conn = null;
            Statement stmt = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                
                // Insert new doctor if form submitted
                String dname = request.getParameter("dname");
                String dspec = request.getParameter("dspec");
                String psswd = request.getParameter("psswd");
                if (dname != null && dspec != null && psswd != null) {
                    String insertQuery = "INSERT INTO doc_info (dname, dspec, psswd) VALUES (?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(insertQuery);
                    pstmt.setString(1, dname);
                    pstmt.setString(2, dspec);
                    pstmt.setString(3, psswd);
                    pstmt.executeUpdate();
                }
                
                // Fetch doctors
                String sql = "SELECT dname, dspec FROM doc_info";
                stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);
        %>
        <table class="table table-hover" id="sample-table-1">
            <thead>
                <tr>
                    <th>Doctor Name</th>
                    <th>Specialization</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("dname") %></td>
                    <td><%= rs.getString("dspec") %></td>
                </tr>
                <%
                    }
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
    </div>
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
