<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="templates/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Invalid Login</title>

<style>
.panel-heading {
    padding: 5px 15px;
}

.panel-footer {
	padding: 1px 15px;
	color: #A0A0A0;
}

.profile-img {
	width: 96px;
	height: 96px;
	margin: 0 auto 10px;
	display: block;
	-moz-border-radius: 50%;
	-webkit-border-radius: 50%;
	border-radius: 50%;
}
</style>
</head>
<body onload="javascript:FormSubmit();">
<b><font size=3 color="white">
There were 3 failed password attempts made. The Password has been changed. 
Please login with the new password</font></b>

	<input type="hidden" name=starttime id="starttime" value="1111-11-11T11:11:11">
	<input type="hidden" name=endtime id="endtime" value="0000-00-00T00:00:00">
	<input type="hidden" name=advisor_email id="advisor_email" value="testadvisor1@uta.edu">
	<input type="hidden" name="email" id="email" value="anand.kadia@mavs.uta.edu">
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
		</body>
</html>