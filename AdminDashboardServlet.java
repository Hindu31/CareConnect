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

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get form input
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Verify admin credentials
        if (isValidAdmin(username, password)) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);

            int totalPatients = 0;
            int totalDoctors = 0;
            int totalAppointments = 0;

            try {
                // Load MySQL Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Query for total patients
                PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM patients_info");
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    totalPatients = rs.getInt(1);
                }

                // Query for total doctors
                stmt = conn.prepareStatement("SELECT COUNT(*) FROM doc_info");
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalDoctors = rs.getInt(1);
                }

                // Query for total appointments
                stmt = conn.prepareStatement("SELECT COUNT(*) FROM apn_info where apstatus='Waiting'");
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalAppointments = rs.getInt(1);
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // HTML Output for Dashboard
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Admin Dashboard</title>");
            out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>");
            out.println("<style>");
            out.println("body { background: linear-gradient(to right, #36D1DC, #5B86E5); font-family: 'Poppins', sans-serif; color: #fff; text-align: center; }");
            out.println(".dashboard-container { margin-top: 50px; }");
            out.println(".dashboard-card { text-align: center; padding: 25px; border-radius: 15px; background: rgba(255, 255, 255, 0.9); box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1); transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out; }");
            out.println(".dashboard-card:hover { transform: translateY(-5px); box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2); }");
            out.println(".dashboard-card h3 { font-size: 22px; font-weight: bold; color: #333; }");
            out.println(".dashboard-card p { font-size: 18px; color: #666; }");
            out.println("a { text-decoration: none; color: inherit; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");

            out.println("<div class='container dashboard-container'>");
            out.println("<div class='row justify-content-center'>");

            // Patients Card
            out.println("<div class='col-md-3 m-2 dashboard-card'>");
            out.println("<a href='mangptnts.jsp' style='text-decoration: none; color: inherit;'>");
            out.println("<h3>Manage Patients</h3>");
            out.println("<p>Total Patients: <b>" + totalPatients + "</b></p>");
            out.println("</a>");
            out.println("</div>");

            // Doctors Card
            out.println("<div class='col-md-3 m-2 dashboard-card'>");
            out.println("<a href='mngdoc.jsp' style='text-decoration: none; color: inherit;'>");
            out.println("<h3>Manage Doctors</h3>");
            out.println("<p>Total Doctors: <b>" + totalDoctors + "</b></p>");
            out.println("</a>");
            out.println("</div>");

            // Appointments Card
            out.println("<div class='col-md-3 m-2 dashboard-card'>");
            out.println("<a href='apn-his.jsp?id=1' style='text-decoration: none; color: inherit;'>");
            out.println("<h3>Appointments</h3>");
            out.println("<p>Total Appointments: <b>" + totalAppointments + "</b></p>");
            out.println("</a>");
            out.println("</div>");

            out.println("</div>");
            out.println("</div>");
            out.println("<div style='position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); "
                    + "display: flex; gap: 15px;'>");

            out.println("<a href='AdminDashboardServlet' style='"
                    + "text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; "
                    + "border-radius: 8px; font-size: 18px; font-weight: bold; "
                    + "box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;'>"
                    + "Dashboard</a>");

            out.println("<a href='index.jsp' style='"
                    + "text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; "
                    + "border-radius: 8px; font-size: 18px; font-weight: bold; "
                    + "box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;'>"
                    + "Home</a>");

            out.println("</div>");


            out.println("</body>");
            out.println("</html>");
        } else {
            out.println("<script>alert('Invalid Username or Password!'); window.location='admin-login.jsp';</script>");
        }
    }

    private boolean isValidAdmin(String username, String password) {
        boolean isValid = false;
        
            if (username.equals("admin") && password.equals("admin")) {
                isValid = true;
            }
           
        return isValid;
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");

        
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username);

            int totalPatients = 0;
            int totalDoctors = 0;
            int totalAppointments = 0;

            try {
                // Load MySQL Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Query for total patients
                PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM patients_info");
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    totalPatients = rs.getInt(1);
                }

                // Query for total doctors
                stmt = conn.prepareStatement("SELECT COUNT(*) FROM doc_info");
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalDoctors = rs.getInt(1);
                }

                // Query for total appointments
                stmt = conn.prepareStatement("SELECT COUNT(*) FROM apn_info where apstatus='Waiting'");
                rs = stmt.executeQuery();
                if (rs.next()) {
                    totalAppointments = rs.getInt(1);
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Admin Dashboard</title>");
            out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>");
            out.println("<style>");
            out.println("body { background: linear-gradient(to right, #36D1DC, #5B86E5); font-family: 'Poppins', sans-serif; color: #fff; text-align: center; }");
            out.println(".dashboard-container { margin-top: 50px; }");
            out.println(".dashboard-card { text-align: center; padding: 25px; border-radius: 15px; background: rgba(255, 255, 255, 0.9); box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.1); transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out; }");
            out.println(".dashboard-card:hover { transform: translateY(-5px); box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2); }");
            out.println(".dashboard-card h3 { font-size: 22px; font-weight: bold; color: #333; }");
            out.println(".dashboard-card p { font-size: 18px; color: #666; }");
            out.println("a { text-decoration: none; color: inherit; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");

            out.println("<div class='container dashboard-container'>");
            out.println("<div class='row justify-content-center'>");

            // Patients Card
            out.println("<div class='col-md-3 m-2 dashboard-card'>");
            out.println("<a href='mangptnts.jsp' style='text-decoration: none; color: inherit;'>");
            out.println("<h3>Manage Patients</h3>");
            out.println("<p>Total Patients: <b>" + totalPatients + "</b></p>");
            out.println("</a>");
            out.println("</div>");

            // Doctors Card
            out.println("<div class='col-md-3 m-2 dashboard-card'>");
            out.println("<a href='mngdoc.jsp' style='text-decoration: none; color: inherit;'>");
            out.println("<h3>Manage Doctors</h3>");
            out.println("<p>Total Doctors: <b>" + totalDoctors + "</b></p>");
            out.println("</a>");
            out.println("</div>");

            // Appointments Card
            out.println("<div class='col-md-3 m-2 dashboard-card'>");
            out.println("<a href='apn-his.jsp?id=1' style='text-decoration: none; color: inherit;'>");
            out.println("<h3>Appointments</h3>");
            out.println("<p>Total Appointments: <b>" + totalAppointments + "</b></p>");
            out.println("</a>");
            out.println("</div>");

            out.println("</div>");
            out.println("</div>");
            out.println("<div style='position: fixed; bottom: 20px; left: 50%; transform: translateX(-50%); "
                    + "display: flex; gap: 15px;'>");

            out.println("<a href='AdminDashboardServlet' style='"
                    + "text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; "
                    + "border-radius: 8px; font-size: 18px; font-weight: bold; "
                    + "box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;'>"
                    + "Dashboard</a>");

            out.println("<a href='index.jsp' style='"
                    + "text-decoration: none; background: #2F88C1; color: white; padding: 12px 25px; "
                    + "border-radius: 8px; font-size: 18px; font-weight: bold; "
                    + "box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3); transition: 0.3s;'>"
                    + "Home</a>");

            out.println("</div>");


            out.println("</body>");
            out.println("</html>");
        } 
    }

    

