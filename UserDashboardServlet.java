import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserDashboardServlet")
public class UserDashboardServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("uname");
        String password = request.getParameter("pwd");

        if (authenticateUser(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            displayDashboard(out, username);
        } else {
            out.println("<script type='text/javascript'>");
            out.println("alert('Invalid username or password!');");
            out.println("window.location='plogin.jsp';");
            out.println("</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String username = request.getParameter("uname");

        displayDashboard(out, username);
    }

    private boolean authenticateUser(String username, String password) {
        boolean isValid = false;
        String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
        String DB_USER = "root";
        String DB_PASSWORD = "admin";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT * FROM patients_info WHERE name = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                isValid = true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }

    private void displayDashboard(PrintWriter out, String username) {
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>User Dashboard</title>");
        out.println("<style>");
        out.println("body { background: linear-gradient(to right, #36D1DC, #5B86E5); font-family: 'Poppins', sans-serif; color: #333; text-align: center; }");
        out.println(".dashboard-container { width: 80%; margin: 50px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1); }");
        out.println(".dashboard-title { font-size: 24px; margin-bottom: 20px; }");
        out.println(".dashboard-cards { display: flex; justify-content: space-between; gap: 20px; flex-wrap: wrap; }");
        out.println(".dashboard-card { flex: 1; min-width: 200px; background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center; transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out; }");
        out.println(".dashboard-card:hover { transform: translateY(-5px); box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2); }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='dashboard-container'>");
        out.println("<h1 class='dashboard-title'>Welcome, " + username + "</h1>");
        out.println("<div class='dashboard-cards'>");
        out.println("<div class='dashboard-card'><h2>My Profile</h2><a href='UserProfile.jsp?pname=" + username + "'>View Profile</a></div>");
        out.println("<div class='dashboard-card'><h2>Update Profile</h2><a href='updateprofile.jsp?pname=" + username + "'>Edit Profile</a></div>");
        out.println("<div class='dashboard-card'><h2>My Appointments</h2><a href='apn-his.jsp?pname=" + username + "&id=99'>View Appointment History</a></div>");
        out.println("<div class='dashboard-card'><h2>Book Appointment</h2><a href='bookapn.jsp?pname=" + username + "'>Book Appointment</a></div>");
        out.println("<div class='dashboard-card'><h2>Insurance</h2><a href='insurance.jsp'>View Plans</a></div>");
        out.println("<div class='dashboard-card'><h2></h2><a href='index.jsp'>LogOut</a></div>");

        out.println("</div>");
        out.println("</div>");
        out.println("<div style='position: fixed; bottom: 20px; right: 20px; display: flex; gap: 10px;'>");

        

        out.println("<a href='index.jsp' style='"
                + "text-decoration: none; background: #5B86E5; color: white; padding: 10px 20px; "
                + "border-radius: 5px; font-size: 16px; font-weight: bold; "
                + "box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.2); transition: 0.3s;'>"
                + "Home</a>");

        out.println("</div>");

        out.println("</body>");
        out.println("</html>");
    }
}
