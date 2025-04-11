<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "root";
    
    String name = "", email = "", contact_no = "", street = "", locality = "", state = "", country = "", aadhar = "";
    byte[] photo = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        String sql = "SELECT * FROM patients_info WHERE name=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            contact_no = rs.getString("contact_no");
            street = rs.getString("street");
            locality = rs.getString("locality");
            state = rs.getString("state");
            country = rs.getString("country");
            aadhar = rs.getString("aadhar");
            photo = rs.getBytes("photo");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <style>
        body {
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            font-family: 'Poppins', sans-serif;
            color: #333;
            text-align: center;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1);
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background: #36D1DC;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Profile</h2>
    <% if (photo != null) { %>
        <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(photo) %>" alt="Profile Picture">
    <% } %>
    
    <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
        <label>Name:</label>
        <input type="text" name="name" value="<%= name %>" readonly>

        <label>Email:</label>
        <input type="email" name="email" value="<%= email %>">

        <label>Contact No:</label>
        <input type="text" name="contact_no" value="<%= contact_no %>">

        <label>Street:</label>
        <input type="text" name="street" value="<%= street %>">

        <label>Locality:</label>
        <input type="text" name="locality" value="<%= locality %>">

        <label>State:</label>
        <input type="text" name="state" value="<%= state %>">

        <label>Country:</label>
        <input type="text" name="country" value="<%= country %>">

        <label>Profile Picture:</label>
        <input type="file" name="photo" required>

        <input type="hidden" name="aadhar" value="<%= aadhar %>">
        
        <button type="submit">Update</button>
    </form>
</div>

</body>
</html>
