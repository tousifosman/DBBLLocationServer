<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:useBean id="loginBean" class="beans.Login"></jsp:useBean>
<jsp:setProperty property="*" name="loginBean"/>
<% if( request.getMethod().equalsIgnoreCase("POST") && request.getParameter("submit") != null) loginBean.login(); %>
<!DOCTYPE html>
<html>
<head>
<title>Login | DBBL Location Server</title>
<%@include file="WEB-INF/header.jspf" %>
</head>
<body>
	<div class="container">
		<div class="row">
			<div id="login_form" class="col-md-4 col-md-offset-4">
				
				<div class="panel panel-default" style="margin-top: 100px">
					<div class="panel-heading">
						<div class="row">
							<div class="col-sm-4"><h5>Login</h5></div>
							<div class="col-sm-8 text-right"><h5>DBBL Location Server</h5></div>
						</div>
					</div>
				  	<div class="panel-body">
					    <% if(loginBean.hasMessege()) { %><div class="text-danger"><%= loginBean.getMessege() %></div><% } %>
						<form method="post">
							<div  class="form-group">
								<label for="username">Username</label>
								<input id="username" class="form-control" type="text" name="username" />
							</div>
							<div class="form-group">
								<label>Password</label>
								<input id="password" class="form-control" type="password" name="password">
							</div>
							<div class="row">
								<div class="col-md-6"><button class="btn btn-primary" type="submit" name="submit" style="width: 100%;margin-bottom: 10px;">Login</button></div>
								<div class="col-md-6"><button class="btn btn-default" type="button" onclick="<%= request.getContextPath() %>/signup.jsp" style="width: 100%;margin-bottom: 10px;">Sign Up</button></div>
							</div>
						</form>		
				  </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>