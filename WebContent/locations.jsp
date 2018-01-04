<%@page import="model.Admin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 

Admin admin;
if( session.getAttribute("session") == null || !(Boolean) session.getAttribute("session")) {
	response.sendRedirect(request.getContextPath()); 
	admin = new Admin();
} else {
	admin = (Admin) session.getAttribute("admin");
}

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Locations | DBBL Location Server</title>
<%@include file="WEB-INF/header.jspf" %>
</head>
<body>
	<nav class="navbar navbar-default">
	  <div class="container">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="#">DBBL Location Server</a>
	    </div>
	
		<ul class="nav navbar-nav navbar-right">
		  <li><a href="<%= request.getContextPath() %>/add_employee.jsp"><small class="glyphicon glyphicon-plus"></small> Add Admin</a></li>
		  <li class="dropdown">
		    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= admin.getName() %><span class="caret"></span></a>
		    <ul class="dropdown-menu">
		      <li><a href="#">Profile</a></li>
		      <li role="separator" class="divider"></li>
		      <li><a href="<%= request.getContextPath() %>/logout">Logout</a></li>
		    </ul>
		  </li>
		</ul>
	  </div><!-- /.container -->
	</nav>
	
	<div class="container">
		<h1>Manage Locations</h1>
		
		<div class="panel panel-default">
		  <!-- Default panel contents -->
		  <div class="panel-heading">
			  <div class="row">
			  	<div class="col-md-6 panel-heading"><strong>Location List</strong></div>
			  	<div class="col-md-6">
			  		<div class="row">
			  			<div class="col-sm-4">
			  				<button class="btn btn-default push-right" style="width: 100%" data-toggle="modal" data-target="#add-zone">
					  			<small class="text-primary glyphicon glyphicon-plus-sign"></small>
					  			Add Zone
				  			</button>
			  			</div>
			  			<div class="col-sm-4">
			  				<button class="btn btn-default push-right" style="width: 100%" data-toggle="modal" data-target="#delete-zone">
					  			<small class="text-danger glyphicon glyphicon-minus-sign"></small>
					  			Delete Zone
				  			</button>
			  			</div>
			  			<div class="col-sm-4">
			  				<button class="btn btn-primary push-right" style="width: 100%">
					  			<small class="glyphicon glyphicon-plus-sign"></small>
					  			Add Location
				  			</button>
			  			</div>
			  		</div>
			  		
			  	</div>
			  </div>
		  </div>
		
		  <!-- Table -->
		  <table id="user_table" class="table table-hover">
		  	<thead>
			  	<tr>
			  		<th>Employee ID</th>
			  		<th>Name</th>
			  		<th>Username</th>
			  	</tr>
		  	</thead>
	  		<tbody>
	  		</tbody>
		  </table>
		</div>	
	</div>
	
	
	<!-- Add Zone Modal -->
	<div class="modal fade" id="add-zone" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Add Zone</h4>
	      </div>
	      <div class="modal-body">
		     <form id="" method="post">
		     	<div class="form-group">
					<label>Zone Name:</label>
					<input class="form-control" type="text" name="name" required="required">
				</div>
			</form>
	      </div>
	      <div class="modal-footer">
	      	<div class="row">
	      		<div class="col-md-6"><h5 class="messege text-left"></h5></div>
		      	<div class="col-md-3"><button type="button" class="btn btn-default" style="width: 100%" data-dismiss="modal">Close</button></div>
		      	<div class="col-md-3"><button id="add-zone-button" type="button" style="width: 100%" class="btn btn-primary">Add Zone</button></div>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Delete Zone Modal -->
	<div class="modal fade" id="delete-zone" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Delete Zone</h4>
	      </div>
	      <div class="modal-body">
			<table id="delete-zone-table" class="table table-hover">
				<thead>
					<tr>
						<th>Zone Name</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
	      </div>
	      <div class="modal-footer">
	      	<div class="row">
	      		<div class="col-md-9"><h5 class="messege text-left"></h5></div>
		      	<div class="col-md-3"><button type="button" class="btn btn-default" style="width: 100%" data-dismiss="modal">Close</button></div>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="view_employee" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Edit Employee</h4>
	      </div>
	      <div class="modal-body">
		     <form id="edit-employee" method="post">
		     	<div class="form-group">
					<label>ID:</label>
					<input class="form-control" type="text" name="id" readonly>
				</div>
				<div class="form-group">
					<label>Username:</label>
					<input class="form-control" type="text" name="username" readonly>
				</div>
				<div class="form-group">
					<label>Name:</label>
			 		<input class="form-control" type="text" name="name" readonly>
				</div>
				<div class="form-group">
					<label>Address:</label>
					<input class="form-control" type="text" name="addr" readonly>
				</div>
				<div class="form-group">
					<label>Email:</label>
					<input class="form-control" type="text" name="email" readonly>
				</div>
				<div class="form-group">
					<label>Phone Number:</label>
					<input class="form-control" type="text" name="phone_no" readonly>
				</div>
			</form>
	      </div>
	      <div class="modal-footer">
	      	<div class="row">
	      		<div class="col-md-6"><h5 class="messege text-left"></h5></div>
		      	<div class="col-md-3"><button type="button" class="btn btn-default" style="width: 100%" data-dismiss="modal">Close</button></div>
		      	<div class="col-md-3"><button id="employee-action" type="button" style="width: 100%" class="btn btn-primary">Edit Employee</button></div>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>
	<script type="text/javascript" src="js/app.js"></script>
</body>
</html>