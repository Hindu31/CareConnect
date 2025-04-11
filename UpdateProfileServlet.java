import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB max image size
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username"); // Assuming username is stored in session
        
        String email = request.getParameter("email");
        String contact_no = request.getParameter("contact_no");
        String street = request.getParameter("street");
        String locality = request.getParameter("locality");
        String state = request.getParameter("state");
        String country = request.getParameter("country");
        Part photoPart = request.getPart("photo");
        
        String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
        String DB_USER = "root";
        String DB_PASSWORD = "admin";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Fetch current data to retain unchanged fields
            String fetchQuery = "SELECT * FROM patients_info WHERE name = ?";
            PreparedStatement fetchStmt = conn.prepareStatement(fetchQuery);
            fetchStmt.setString(1, username);
            ResultSet rs = fetchStmt.executeQuery();
            
            if (rs.next()) {
                if (email == null || email.isEmpty()) email = rs.getString("email");
                if (contact_no == null || contact_no.isEmpty()) contact_no = rs.getString("contact_no");
                if (street == null || street.isEmpty()) street = rs.getString("street");
                if (locality == null || locality.isEmpty()) locality = rs.getString("locality");
                if (state == null || state.isEmpty()) state = rs.getString("state");
                if (country == null || country.isEmpty()) country = rs.getString("country");
            }
            
            String updateQuery = "UPDATE patients_info SET email=?, contact_no=?, street=?, locality=?, state=?, country=?, photo=? WHERE name=?";
            PreparedStatement pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, email);
            pstmt.setString(2, contact_no);
            pstmt.setString(3, street);
            pstmt.setString(4, locality);
            pstmt.setString(5, state);
            pstmt.setString(6, country);
            
            // Handling profile picture update
            if (photoPart != null && photoPart.getSize() > 0) {
                InputStream inputStream = photoPart.getInputStream();
                pstmt.setBlob(7, inputStream);
            } else {
                // Retain old image if no new image is uploaded
                pstmt.setNull(7, Types.BLOB);
            }
            
            pstmt.setString(8, username);
            int rows = pstmt.executeUpdate();
            
            if (rows > 0) {
            	out.println("<script>alert('Profile updated successfully!'); window.location='UserProfile.jsp?pname=" + rs.getString("name") + "';</script>");
            } else {
                out.println("<script>alert('Error updating profile!'); window.history.back();</script>");
            }
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Database error! Try again.'); window.history.back();</script>");
        }
    }
}
