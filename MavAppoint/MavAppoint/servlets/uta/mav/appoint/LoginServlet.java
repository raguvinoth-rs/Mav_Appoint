package uta.mav.appoint;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import uta.mav.appoint.beans.GetSet;
import uta.mav.appoint.db.DatabaseManager;
import uta.mav.appoint.login.LoginUser;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;
	int loginAttempt;
	public Connection connectDB(){
		try
	    {
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
	    String jdbcUrl = "jdbc:mysql://localhost:3306/MavAppointDB";
	    String userid = "root";
	    String password = "willpower";
	    Connection conn = DriverManager.getConnection(jdbcUrl,userid,password);
	    System.out.println("connection status"+conn);
	    return conn;
	    }
	    catch (Exception e){
	        System.out.println(e.toString());
	    }
	    return null;
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		request.getRequestDispatcher("/WEB-INF/jsp/views/login.jsp").forward(request,response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		session = request.getSession();
		String emailAddress = request.getParameter("emailAddress");
		String password = request.getParameter("password");
		GetSet sets = new GetSet();
		sets.setEmailAddress(emailAddress);
		sets.setPassword(password);
		try{
			//call db manager and authenticate user, return value will be 0 or
			//an integer indicating a role
			DatabaseManager dbm = new DatabaseManager();
			LoginUser user = dbm.checkUser(sets);
//			loginAttempt = (Integer) session.getAttribute("loginCount");
//			if(session.getAttribute("loginCount") == null){
//				session.setAttribute("loginCount", 0);
//				loginAttempt = 0;				
//			}
//			else{
//				loginAttempt = (Integer) session.getAttribute("loginCount");
//			}
//			
			if(user != null){
				session.setAttribute("user", user);
				response.sendRedirect("index");
				session.setAttribute("loginCount", 0);
				loginAttempt = 0;
			}
			else{
				//redirect back to login if authentication fails
				//need to add a "invalid username or password" response
				
				session.setAttribute("loginCount", loginAttempt++);
				if(loginAttempt > 2){
					System.out.println("Number of Failed Attempts: "+loginAttempt);
					System.out.println("There were 3 failed password attempts made");
					//response.sendRedirect("forgetPassword.html?var1="+emailAddress+"");
					//response.sendRedirect("index");
					
					Connection conn = connectDB();
					PreparedStatement statement;
					String command = "UPDATE mavappointdb.user SET USERPASSWORD='Newpass12!' WHERE EMAIL=?";
					//String command = "UPDATE mavappointdb.user SET VALIDATED=0 WHERE EMAIL=?";
					statement=conn.prepareStatement(command);
					statement.setString(1, emailAddress);
					statement.executeUpdate();
					conn.close();
					System.out.println("The Password for the Email Address "+emailAddress+" has been changed and Mail sent to the respective Email Address");
					RequestDispatcher requestDispatcher = request
		                    .getRequestDispatcher("/WEB-INF/jsp/views/invalidLogin.jsp");
		            requestDispatcher.forward(request, response);
				}
				else{
					request.getRequestDispatcher("/WEB-INF/jsp/views/login.jsp").forward(request,response);
				}
			}
		}
		catch(Exception e){
			System.out.println(e);
			response.sendRedirect("login");
		}
	}
}
