<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forgot Password</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="javax.sql.*"%>
	<%
		String userid=request.getParameter("usr"); 
		session.putValue("userid",userid); 
		String emailid=request.getParameter("emailid"); 
		Class.forName("com.mysql.jdbc.Driver"); 
		java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/MavAppointDB","root","willpower"); 
		Statement st= con.createStatement(); 
		ResultSet rs=st.executeQuery("SELECT * FROM mavappointdb.user where USERID='"+userid+"'"); 
		PreparedStatement pstatement = null;
		if(rs.next()) 
		{ 	
		if(rs.getString(2).equals(emailid)) 
		{ 
			//ResultSet rs1=st.executeQuery("UPDATE `mavappointdb`.`user` SET `USERPASSWORD`='pwchangetemp' WHERE `USERID`='"+userid+"'");
			String queryString = "UPDATE mavappointdb.user SET USERPASSWORD='pwchangetemp' WHERE USERID='"+userid+"'";
			pstatement = con.prepareStatement(queryString);
			int updateQuery = pstatement.executeUpdate();
			out.println("New Password has been sent to Your Email. Please Log In again with that."); 

		} 
		else 
		{ 
		out.println("Invalid information try again"); 
		} 
		} 
		else 
	%>
<a href="index">Home</a>
</body>
</html>