package uta.mav.appoint.db.command;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import uta.mav.appoint.beans.Appointment;

public class UpdateAppointment extends SQLCmd{
	String pname;
	String advisingDate;
	String advisingStartTime;
	String advisingEndTime;
	String appointmentType;
	String advisorEmail;
	String description;
	String studentid;
	int appointmentId;
	String studentEmail;
	int advisor_id;
	
	int id;
	Boolean b = false;
	
	public UpdateAppointment(Appointment a){
		advisingDate = a.getAdvisingDate();
		advisingStartTime = a.getAdvisingStartTime();
		advisingEndTime = a.getAdvisingEndTime();
		appointmentType = a.getAppointmentType();
		description = a.getDescription();
		studentid = a.getStudentid();
		studentEmail = a.getStudentEmail();
		
		
		id = a.getAppointmentId();
	}
	
	public void queryDB(){
		try{
			String command = "UPDATE appointments SET description=?,studentid=?,student_userid=?, advising_date=?, advising_starttime=?, advising_endtime=?, appointment_type=?  where id=?";
			PreparedStatement statement = conn.prepareStatement(command);
			statement.setString(1, description);
			statement.setString(2, studentEmail);
			statement.setString(3, studentid);
			statement.setString(4, advisingDate);
			statement.setString(5, advisingStartTime);
			statement.setString(6, advisingEndTime);
			statement.setString(7, appointmentType);
			statement.setInt(8, id);
			statement.executeUpdate();
			
			//Getting UserID of Advisor
			command = "SELECT userid from advisor_settings where pname=?";
			statement=conn.prepareStatement(command);
			statement.setString(1,pname);
			ResultSet rs = statement.executeQuery();
			while(rs.next()){
				advisor_id = rs.getInt(1);
			}
			
			//Updating the Advising_Schedule Table
			command = "UPDATE advising_schedule SET studentid=? where userid=? AND advising_date=? and advising_starttime >= ? and advising_endtime <= ?";
			statement=conn.prepareStatement(command);
			statement.setString(1,studentid);
			statement.setInt(2, advisor_id);
			statement.setString(3, advisingDate);
			statement.setString(4, advisingStartTime);
			statement.setString(5, advisingEndTime);
			statement.executeUpdate();
			
			
			b=true;
		}
		catch(SQLException sq){
			System.out.println(sq.toString());
		}
	}
	
	public void processResult(){
		result.add(b);
	}

}
