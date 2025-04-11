import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("pemail");
            String pno = request.getParameter("pno");
            String street = request.getParameter("street");
            String locality = request.getParameter("locality");
            String aadhar = request.getParameter("aadhar");
            String state = request.getParameter("state");
            String country = request.getParameter("country");
            String pswd = request.getParameter("pswd");

            Part filePart = request.getPart("photo");
            InputStream photoInput = filePart != null ? filePart.getInputStream() : null;

            // Check for missing values
            if (name == null || email == null || pno == null || street == null || locality == null ||
                aadhar == null || state == null || country == null || pswd == null || photoInput == null) {
                response.sendRedirect("register.jsp?error=One or more fields are missing!");
                return;
            }

            // Connect to Database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/hospital_database", "root", "admin");

            // Insert Data into Database
            String query = "INSERT INTO patients_info (name, email, contact_no, street, locality, aadhar, state, country, password, photo) " +
                           "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, pno);
            pst.setString(4, street);
            pst.setString(5, locality);
            pst.setString(6, aadhar);
            pst.setString(7, state);
            pst.setString(8, country);
            pst.setString(9, pswd);
            pst.setBlob(10, photoInput);

            int rowsAffected = pst.executeUpdate();
            con.close();

            if (rowsAffected > 0) {
                response.sendRedirect("plogin.jsp?message=Registration Successful");
            } else {
                response.sendRedirect("newuser.html?error=Registration Failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("newuser.html?error=Database Error: " + e.getMessage());
        }

    }
}
