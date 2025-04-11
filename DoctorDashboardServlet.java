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

@WebServlet("/DoctorDashboardServlet")
public class DoctorDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3307/hospital_database?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("uname");
        String password = request.getParameter("pwd");

        if (isValidDoctor(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("doctorUser", username);
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Doctor Dashboard</title>");
            out.println("<style>");
            out.println("body { background: linear-gradient(to right, #36D1DC, #5B86E5); font-family: 'Poppins', sans-serif; color: #fff; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }");
            out.println(".dashboard-container { display: flex; flex-direction: column; align-items: center; padding: 30px; border-radius: 12px; background: rgba(255, 255, 255, 0.9); box-shadow: 0px 10px 15px rgba(0, 0, 0, 0.1); width: 400px; }");
            out.println(".dashboard-title { font-size: 28px; margin-bottom: 20px; color: #333; }");
            out.println(".dashboard-card { width: 100%; text-align: center; background: white; padding: 25px; border-radius: 10px; box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.1); transition: all 0.3s ease-in-out; text-decoration: none; color: inherit; }");
            out.println(".dashboard-card:hover { transform: translateY(-5px); box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2); }");
            out.println(".dashboard-card img { width: 70px; margin-bottom: 10px; }");
            out.println(".dashboard-card h2 { font-size: 20px; color: #333; }");
            out.println(".history-link { display: block; margin-top: 15px; font-size: 16px; color: #0066cc; text-decoration: underline; font-weight: bold; }");
            out.println(".history-link:hover { color: #004499; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='dashboard-container'>");
            out.println("<h1 class='dashboard-title'>DOCTOR | DASHBOARD</h1>");
            out.println("<a href='apn-his.jsp?id=2' class='dashboard-card'>");
            out.println("<img src='https://cdn-icons-png.flaticon.com/512/2920/2920320.png' alt='Appointments'>");
            out.println("<h2>My Appointments</h2>");
            out.println("</a>");
            out.println("<a href='apn-his.jsp?id=2' class='history-link'>View Appointment History</a>");
            out.println("</div>");
            out.println("<div style='position: fixed; bottom: 20px; right: 20px; display: flex; gap: 10px;'>");

            out.println("<a href='DoctorDashboardServlet' style='"
                    + "text-decoration: none; background: #36D1DC; color: white; padding: 10px 20px; "
                    + "border-radius: 5px; font-size: 16px; font-weight: bold; "
                    + "box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.2); transition: 0.3s;'>"
                    + "Dashboard</a>");

            out.println("<a href='index.jsp' style='"
                    + "text-decoration: none; background: #5B86E5; color: white; padding: 10px 20px; "
                    + "border-radius: 5px; font-size: 16px; font-weight: bold; "
                    + "box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.2); transition: 0.3s;'>"
                    + "Home</a>");

            out.println("</div>");

            out.println("</body>");
            out.println("</html>");
        } else {
            out.println("<script>alert('Invalid Username or Password!'); window.location='Doclogin.jsp';</script>");
        }
    }

    private boolean isValidDoctor(String username, String password) {
        boolean isValid = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM doc_info WHERE dname=? AND psswd=?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                isValid = true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("uname");
        //String password = request.getParameter("pwd");

            HttpSession session = request.getSession();
            session.setAttribute("doctorUser", username);
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Doctor Dashboard</title>");
            out.println("<style>");
            out.println("body { background: linear-gradient(to right, #36D1DC, #5B86E5); font-family: 'Poppins', sans-serif; color: #fff; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }");
            out.println(".dashboard-container { display: flex; flex-direction: column; align-items: center; padding: 30px; border-radius: 12px; background: rgba(255, 255, 255, 0.9); box-shadow: 0px 10px 15px rgba(0, 0, 0, 0.1); width: 400px; }");
            out.println(".dashboard-title { font-size: 28px; margin-bottom: 20px; color: #333; }");
            out.println(".dashboard-card { width: 100%; text-align: center; background: white; padding: 25px; border-radius: 10px; box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.1); transition: all 0.3s ease-in-out; text-decoration: none; color: inherit; }");
            out.println(".dashboard-card:hover { transform: translateY(-5px); box-shadow: 0px 12px 20px rgba(0, 0, 0, 0.2); }");
            out.println(".dashboard-card img { width: 70px; margin-bottom: 10px; }");
            out.println(".dashboard-card h2 { font-size: 20px; color: #333; }");
            out.println(".history-link { display: block; margin-top: 15px; font-size: 16px; color: #0066cc; text-decoration: underline; font-weight: bold; }");
            out.println(".history-link:hover { color: #004499; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='dashboard-container'>");
            out.println("<h1 class='dashboard-title'>DOCTOR | DASHBOARD</h1>");
            out.println("<a href='apn-his.jsp?id=2' class='dashboard-card'>");
            out.println("<img src='https://cdn-icons-png.flaticon.com/512/2920/2920320.png' alt='Appointments'>");
            out.println("<h2>My Appointments</h2>");
            out.println("</a>");
            out.println("<a href='apn-his.jsp?id=2' class='history-link'>View Appointment History</a>");
            out.println("</div>");
            out.println("<div style='position: fixed; bottom: 20px; right: 20px; display: flex; gap: 10px;'>");

            out.println("<a href='DoctorDashboardServlet' style='"
                    + "text-decoration: none; background: #36D1DC; color: white; padding: 10px 20px; "
                    + "border-radius: 5px; font-size: 16px; font-weight: bold; "
                    + "box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.2); transition: 0.3s;'>"
                    + "Dashboard</a>");

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

    
    
    


