<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("pname");

    String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "admin";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        String sql = "SELECT * FROM patients_info WHERE name = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body { 
            font-family: 'Poppins', sans-serif; 
            background: linear-gradient(to right, #36D1DC, #5B86E5); 
            text-align: center; 
            color: #333;
        }
        .profile-container { 
            width: 50%; 
            margin: 50px auto; 
            background: white; 
            padding: 30px; 
            border-radius: 10px; 
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        .profile-pic { 
            width: 150px; 
            height: 150px; 
            border-radius: 50%; 
            object-fit: cover; 
            margin-bottom: 10px; 
            border: 3px solid #5B86E5;
        }
        .profile-info { 
            text-align: left; 
            margin-top: 20px;
        }
        .profile-info p { 
            margin: 8px 0; 
            font-size: 18px; 
            font-weight: 500;
        }
        .back-link, .update-link { 
            margin-top: 20px; 
            display: inline-block; 
            font-size: 18px; 
            text-decoration: none; 
            padding: 10px 15px; 
            border-radius: 5px; 
            background-color: #007BFF; 
            color: white;
            transition: 0.3s ease-in-out;
        }
        .back-link:hover, .update-link:hover { 
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h2>User Profile</h2>
        <% 
            // Display Profile Picture
            Blob photoBlob = rs.getBlob("photo");
            if (photoBlob != null) {
                byte[] imgData = photoBlob.getBytes(1, (int) photoBlob.length());
                String base64Image = new String(java.util.Base64.getEncoder().encode(imgData));
        %>
            <img src="data:image/jpeg;base64,<%= base64Image %>" class="profile-pic" alt="Profile Picture">
        <% } else { %>
            <img src="default-profile.png" class="profile-pic" alt="Default Profile Picture">
        <% } %>

        <div class="profile-info">
            <p><strong>Name:</strong> <%= rs.getString("name") %></p>
            <p><strong>Email:</strong> <%= rs.getString("email") %></p>
            <p><strong>Contact:</strong> <%= rs.getString("contact_no") %></p>
            <p><strong>Street:</strong> <%= rs.getString("street") %></p>
            <p><strong>Locality:</strong> <%= rs.getString("locality") %></p>
            <p><strong>Aadhar:</strong> <%= rs.getString("aadhar") %></p>
            <p><strong>State:</strong> <%= rs.getString("state") %></p>
            <p><strong>Country:</strong> <%= rs.getString("country") %></p>
        </div>

        <a href="UserDashboardServlet?uname=<%= username %>" class="back-link">← Back to Dashboard</a>
        <a href="updateprofile.jsp?pname=<%= username %>" class="update-link">Update Profile</a>
    </div>
</body>
</html>
<%
        } else {
            out.println("<h2>User not found!</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
