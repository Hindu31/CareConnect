<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insurance Plans</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; text-align: center; }
        .container { max-width: 600px; margin: 50px auto; padding: 20px; background: white; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        input, button { width: 90%; padding: 10px; margin: 10px 0; border-radius: 5px; }
        button { background: #5B86E5; color: white; border: none; cursor: pointer; }
        button:hover { background: #36D1DC; }
        table { width: 100%; margin-top: 20px; border-collapse: collapse; }
        table, th, td { border: 1px solid #ddd; padding: 10px; }
        th { background: #5B86E5; color: white; }
    </style>
</head>
<body>

<div class="container">
    <h2>Find Insurance Plans</h2>
    <form method="post">
        <label>Enter Your Age:</label>
        <input type="number" name="age" required>
        <button type="submit">View Plans</button>
    </form>

    <% 
        String ageParam = request.getParameter("age");
        if (ageParam != null) {
            int age = Integer.parseInt(ageParam);
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/hospital_database", "root", "admin");

                String sql = "SELECT p.plan_name, p.provider, p.coverage_details, pk.duration, pk.price " +
                             "FROM insurance_plans p " +
                             "JOIN insurance_packages pk ON p.id = pk.plan_id " +
                             "WHERE ? BETWEEN p.min_age AND p.max_age";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, age);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    out.println("<h3>Available Insurance Plans:</h3>");
                    out.println("<table>");
                    out.println("<tr><th>Plan Name</th><th>Provider</th><th>Coverage</th><th>Duration</th><th>Price</th></tr>");
                    
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("plan_name") + "</td>");
                        out.println("<td>" + rs.getString("provider") + "</td>");
                        out.println("<td>" + rs.getString("coverage_details") + "</td>");
                        out.println("<td>" + rs.getString("duration") + "</td>");
                        out.println("<td>$" + rs.getDouble("price") + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    
                    out.println("</table>");
                } else {
                    out.println("<p style='color:red;'>No insurance plans available for your age group.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error fetching data. Please try again.</p>");
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        }
    %>
    <div>
    <a href="UserDashboardServlet">Back</a>
    </div>
</div>

</body>
</html>
