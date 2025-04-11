<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    // Database connection details
    String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "root";

    // Retrieve appointment name (pname)
    String pname = request.getParameter("pname");
    String dname = request.getParameter("dname");
    String solution = request.getParameter("solution");
    boolean isSubmitted = "true".equals(request.getParameter("submitted"));

    if (solution != null && !solution.trim().isEmpty()) {
        try {
            // Load database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to update solution
            String query = "UPDATE apn_info SET solution = ? WHERE pname = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, solution);
            pstmt.setString(2, pname);

            int updated = pstmt.executeUpdate();
            conn.close();

            if (updated > 0) {
                response.sendRedirect("apn-his.jsp?id=2&doctorUser=" + dname + "&submitted=true");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Write Solution</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #36D1DC, #5B86E5);
            text-align: center;
            padding: 50px;
            color: #333;
        }
        .container {
            background: white;
            padding: 30px;
            width: 50%;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        label {
            font-size: 18px;
            font-weight: bold;
            color: #555;
        }
        textarea {
            width: 100%;
            height: 120px;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            resize: none;
        }
        button {
            background: #ff5722;
            color: white;
            padding: 12px 24px;
            border: none;
            cursor: pointer;
            margin-top: 15px;
            border-radius: 5px;
            font-size: 16px;
            transition: 0.3s;
        }
        button:hover {
            background: #e64a19;
        }
        .message {
            color: green;
            font-weight: bold;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Write Solution for Appointment #<%= pname != null ? pname : "Unknown" %></h2>
    
    <% if (isSubmitted) { %>
        <p class="message">Solution submitted successfully!</p>
    <% } else { %>
        <form action="writeSolution.jsp" method="POST">
            <input type="hidden" name="pname" value="<%= pname %>">
            <label>Enter Solution:</label>
            <textarea name="solution" placeholder="Enter solution here..." required></textarea><br>
            <button type="submit">Submit Solution</button>
        </form>
    <% } %>
</div>

</body>
</html>
