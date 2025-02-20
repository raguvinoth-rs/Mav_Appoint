<jsp:include page='<%=(String) request.getAttribute("includeHeader")%>' />

 
<style>
.custab{
    border: 1px solid #ccc;
    padding: 5px;
    margin: 5% 0;
    box-shadow: 3px 3px 2px #ccc;
    transition: 0.5s;
    background-color:#e67e22;
    }
.custab:hover{
    box-shadow: 3px 3px 0px transparent;
    transition: 0.5s;
    }
</style>


<div class="container">
    <div class="btn-group">
	<form action="appointments" method="post" name="cancel">
	
	<input type=hidden name=cancel_button id="cancel_button">
    <input type=hidden name=edit_button id="edit_button">
    <div class="row col-md-16  custyle">
    <table class="table table-striped custab">
    <thead>
        <tr>
            <th>Advisor Name</th>
            <th>Appointment Date</th>
			<th>Start Time</th>
			<th>End Time</th>
			<th>Advising Type</th>
			<th>Advising Email</th>
			<th>Description</th>
			<th>UTA Student ID</th>
<!--             <th>Student Email</th> -->
            <th class="text-center">Action</th>
        </tr>
    </thead>
            		<%@ page import= "java.util.ArrayList" %>
		    		<%@ page import= "uta.mav.appoint.beans.Appointment" %>
		    		<!-- begin processing appointments  -->
		    		<% ArrayList<Appointment> array = (ArrayList<Appointment>)session.getAttribute("appointments");
		    			if (array != null){%>
							<%for (int i=0;i<array.size();i++){ %>
							<tr>
                				<td><%=array.get(i).getPname()%></td>
                				<td><%=array.get(i).getAdvisingDate()%></td>
								<td><%=array.get(i).getAdvisingStartTime()%></td>
								<td><%=array.get(i).getAdvisingEndTime()%></td>
								<td><%=array.get(i).getAppointmentType()%></td>
								<td><%=array.get(i).getAdvisorEmail()%></td>
								<td><%=array.get(i).getDescription() %></td>
								<td><%=array.get(i).getStudentid()%></td>
<%-- 								<td><%=array.get(i).getStudentEmail()%></td> --%>
								<td class="text-center"><button type="button" id=button1<%=i%> onclick="button<%=i%>()">Cancel</button></td>
								<td class="text-center"><button type="button" id=button2_<%=i%> onclick="button_<%=i%>()">Edit</button></td>
								<td class="text-center"><button type="button" id=button3_<%=i%> onclick="button__<%=i%>()">Email</button></td>
								<td class="text-center"><button type="button" id=button4_<%=i%> onclick="javascript:FormSubmit();">Penality</button></td>
								<input type="hidden" name=starttime id="starttime" value="2222-22-22T22:22:22">
								<input type="hidden" name=endtime id="endtime" value="0000-00-00T00:00:00">
								<input type="hidden" name=advisor_email id="advisor_email" value="testadvisor1@uta.edu">
								<input type="hidden" name="email" id="email" value="anand.kadia@mavs.uta.edu">
							</tr>
								<script> function button<%=i%>(){
										document.getElementById("cancel_button").value = "<%=array.get(i).getAppointmentId()%>"; 
										if (validate() == true){
											cancel.submit();
										}
								}</script>
								<script> function button_<%=i%>(){
										document.getElementById("id2").value = "<%=array.get(i).getAppointmentId()%>"; 
										document.getElementById("apptype").value = "<%=array.get(i).getAppointmentType()%>"; 
										document.getElementById("date").value = "<%=array.get(i).getAdvisingDate()%>";
										document.getElementById("start").value = "<%=array.get(i).getAdvisingStartTime()%>"; 
										document.getElementById("end").value = "<%=array.get(i).getAdvisingEndTime()%>"; 
										document.getElementById("pname").value = "<%=array.get(i).getPname()%>"; 
										document.getElementById("description").value = "<%=array.get(i).getDescription()%>";
										$('#addApptModal').modal();
								}</script>
								<script> function button__<%=i%>(){
										document.getElementById("to").value = "<%=array.get(i).getStudentEmail()%>";
										$('#emailModal').modal();
								}</script>
							<script>	
								function FormSubmit(){
								var student_email = document.getElementById("email").value;
								var advisor_email = document.getElementById("advisor_email").value;
								var starttime = document.getElementById("starttime").value;
								var endtime = document.getElementById("endtime").value;
								var params = ('student_email='+student_email+'&advisor_email='+advisor_email+'&starttime='+starttime+'&endtime='+endtime);
								var xmlhttp;
								xmlhttp = new XMLHttpRequest();
								xmlhttp.onreadystatechange=function(){
									
								}
								xmlhttp.open("POST","mail",true);
								xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
								xmlhttp.setRequestHeader("Content-length",params.length);
								xmlhttp.setRequestHeader("Connection","close");
								xmlhttp.send(params);
							}
							</script>
								
								<script> function emailSend(){
									var to = document.getElementById("to").value;
									var body = document.getElementById("email").value;
									var subject = document.getElementById("subject").value;
									var params = ('to='+to+'&body='+body+'&subject='+subject);
									var xmlhttp;
									xmlhttp = new XMLHttpRequest();
									xmlhttp.onreadystatechange=function(){
										if (xmlhttp.readyState==4){
											alert("Email sent.");	
											return false;
										}
									}
									xmlhttp.open("POST","notify",true);
									xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
									xmlhttp.setRequestHeader("Content-length",params.length);
									xmlhttp.setRequestHeader("Connection","close");
									xmlhttp.send(params);
								}
								</script>
								</div>
						<%	}
		    			}
		    			%> 
					 <!-- end processing advisors -->	 
					</table>
				</form>
			</div>
		</div>
	<form name=addAppt action="manage" onsubmit="return validate2()" method="post">
			<div class="modal fade" id="addApptModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id=addApptTypeLabel">Update Appointment</h4>
				</div>
				<div class="modal-body">
						<input type="hidden" name=id2 id="id2" readonly>
						<b>Type:</b><input type="label" name=apptype id="apptype"><br>
						<b>Date:    </b><input type="text" name=date id="date" readonly><br>
						<b>Start:   </b><input type="label" name=start id="start" readonly><br>
						<b>End:     </b><input type="label" name=end id="end" readonly><br>
						<input type="hidden" name=pname id="pname">
						<b>UTA EmailID: </b><br><input type="text" name=studentid id="studentid"><br>
						<b>UTA Student ID: </b><br><input type="text" name=utastudentid id="utastudentid"><br>
						<b>Description:</b><br><textarea rows=4 columns="10" name=description id="description"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default"
						data-dismiss="modal"> Close 
					</button>
					<input type="submit" value="Submit">
				</div>
			</div>
		</div>
	</div>
	</form>
<form name=emailSubmit onsubmit="return emailSend()">
<div class="modal fade" id="emailModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Send message</h4>
				</div>
				<div class="modal-body">
						<b>Subject:</b><br><input type=text name=subject id="subject"><br>
						<b>Message:</b><br><textarea rows=4 columns="10" name=email id="email"></textarea><br>
						<input type=hidden name=to id="to"><br>
						</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default"
						data-dismiss="modal"> Close 
					</button>
					<input type="submit" value="Submit">
				</div>
			</div>
		</div>
	</div>
</form>
<script>
function validate(){
		return confirm('Are you sure you want to delete this appointment?');	
	}
function validate2(){
		if (document.getElementById("studentid").value == ""){
			alert("Student ID is required.");
			return false;
		}
		if (document.getElementById("description").value.length > 100){
			alert("Description is too long, please shorten it.");
			return false;
		}
	}
</script>
<%@include file="templates/footer.jsp" %>