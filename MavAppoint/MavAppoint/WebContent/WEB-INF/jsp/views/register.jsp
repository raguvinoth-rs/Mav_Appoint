<%@include file="templates/header.jsp"%>
<html>
<head>
<script type="text/javascript">
var ieDOM = false, nsDOM = false;
var stdDOM = document.getElementById;

function initMethod()
{
	//Determine the browser support for the DOM
	if( !stdDOM )
	{
		ieDOM = document.all;
		
		if( !ieDOM )
		{
			nsDOM = ((navigator.appName.indexOf('Netscape') != -1) && (parseInt(navigator.appVersion) ==4));
		}
	}
	
	passwordChanged();
}

function getObject(objectId)
{
	if (stdDOM) return document.getElementById(objectId);
	if (ieDOM) return document.all[objectId];
	if (nsDOM) return document.layers[objectId];
}

function getObjectStyle(objectId)
{
	if (nsDOM) return getObject(objectId);
	var obj = getObject(objectId);
	return obj.style;
}

function showDefault(objectId)
{
	showCell(objectId, "#E2E2E2", "#E2E2E2");
}

function showCell(objectId, foreColor, backColor)
{
	getObjectStyle(objectId).color = foreColor;
	getObjectStyle(objectId).backgroundColor = backColor;
}

function showWeak()
{
	showCell("pwWeak", "Black", "#FF6666");
	showDefault("pwMedium");
	showDefault("pwStrong");
}

function showMedium()
{
	showCell("pwWeak", "#FFCC66", "#FFCC66");
	showCell("pwMedium", "Black", "#FFCC66");
	showDefault("pwStrong");
}

function showStrong()
{
	showCell("pwWeak", "#80FF80", "#80FF80");
	showCell("pwMedium", "#80FF80", "#80FF80");
	showCell("pwStrong", "Black", "#80FF80");
}

function showUndetermined()
{
	showDefault("pwWeak");
	showDefault("pwMedium");
	showDefault("pwStrong");
}

function passwordChanged()
{
	var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
	var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
	var enoughRegex = new RegExp("(?=.{6,}).*", "g");
	var pwd = getObject("password").value;
	
	if( false == enoughRegex.test(pwd) )
	{
		showUndetermined();
	}
	
	else if( strongRegex.test(pwd) )
	{
		showStrong();
	}
	
	else if( mediumRegex.test( pwd ) )
	{
		showMedium();
	}
	
	else
	{
		showWeak();
	}
}

function validateConfirmPassword()
{
	if(validate_required((password.value != repeatPassword.value),"Your password and confirmation password do not match.")==false)
	{
		repeatPassword.focus();return false;
	}
}

function get_action(form) {
    var v = g-recaptcha.getResponse();
    if(v.length == 0)
    {
        document.getElementById('captcha').innerHTML="You can't leave Captcha Code empty";
        return false;
    }
    if(v.length != 0)
    {
        document.getElementById('captcha').innerHTML="Captcha completed";
        return true; 
    }
}
</script>
<script src='https://www.google.com/recaptcha/api.js'></script>

</head>

<body>
<div class="container">
	<form action="#" method="post">
	
    <div class="row">
		<div class="col-md-4 col-lg-4">
			<div class="form-group">

            <label style="color:#F90" for="userid">User ID</label>
            <input type="text" class="form-control" id=userid
            placeholder="1000xxxxxx or 6000xxxxxx" name="userid" required="required">
            
            <label style="color:#F90" for="emailAddress">Email Address</label>
            <input type="email" class="form-control" id=emailAddress name="emailAddress"
            placeholder="firstname.lastname@mavs.uta.edu" required="required">
            
            <label style="color:#F90" for="password">Password</label>
            <input type="password" class="form-control" id=password name="password" onkeyup="return passwordChanged();"required="required">
                          
            <TABLE style="BORDER-RIGHT: black thin solid; BORDER-TOP: black thin solid; FONT-SIZE: 75%; BORDER-LEFT: black thin solid; BORDER-BOTTOM: black thin solid; width:100%">
            <TR>
            <TD id="pwWeak" style="BORDER-RIGHT: black thin solid" align="center" width="34%" title="Has at least six characters">Weak</TD>
            <TD id="pwMedium" style="BORDER-RIGHT: black thin solid" align="center" width="33%" title="Has a mix of numbers, lower & upper case characters.">Medium</TD>
            <TD id="pwStrong" align="center" width="33%" title="Has numbers, special characters, lower & upper case characters.">Strong</TD>
            </TR>
            
            </TABLE>
			
            <label style="color:#F90" for="repeatPassword">Repeat Password</label>
			<input type="password" class="form-control" id=repeatPassword required="required" >
			<br>
			<div class="g-recaptcha" data-sitekey="6LcCnRITAAAAABzlmcjGPZAPEefbz4qYrPLG4qE9"></div>
	
 	
			</div>
			</div>
	</div>
	<input type="submit" class="btn btn-primary" onClick="get_action(this)" value="Submit">
	</form>
</div>
</body>	
</html>
<%@include file="templates/footer.jsp"%>