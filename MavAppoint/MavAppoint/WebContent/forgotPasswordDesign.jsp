<%@ include file="WEB-INF/jsp/views/templates/header.jsp" %>
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

 <div class="container" style="margin-top:40px">
		<div class="row">
			<div class="col-sm-6 col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong> Forgot Your Password ?</strong>
					</div>
					<div class="panel-body">
						<form role="form" action="forgotPassword.jsp" method="POST">
							<fieldset>
								<div class="row">
									<div class="col-sm-12 col-md-10  col-md-offset-1 ">
										<div class="form-group">
										<div class="input-group">
												<span class="input-group-addon">
													<Label>Student ID: </Label>
												</span> 
												<input type="text" class="form-control" name=usr placeholder="1000*">
											</div>
											<div class="input-group">
												<span class="input-group-addon">
													<Label>Email: </Label>
												</span> 
												<input type="text" class="form-control" name=emailid placeholder="Your Email">
											</div>
										</div>
										<div class="form-group">
											<input type="submit" class="btn btn-lg btn-primary btn-block" value="Submit">
										</div>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
					<div class="panel-footer ">
					</div>
                </div>
			</div>
		</div>
	</div>


<%@ include file="WEB-INF/jsp/views/templates/footer.jsp" %>