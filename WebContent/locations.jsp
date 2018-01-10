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
 <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #description {
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
      }

      #infowindow-content .title {
        font-weight: bold;
      }

      #infowindow-content {
        display: none;
      }

      #map #infowindow-content {
        display: inline;
      }
      
      #map {
      	height: 300px;
		margin-top: 20px;
		border-radius: 5px;
		border: 1px solid #ccc;
      }

      .pac-card {
        margin: 10px 10px 0 0;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        background-color: #fff;
        font-family: Roboto;
      }

      #pac-container {
        padding-bottom: 12px;
        margin-right: 12px;
      }
      
      .pac-container {
      	z-index: 10000;
      }

      .pac-controls {
        display: inline-block;
        padding: 5px 11px;
      }

      .pac-controls label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 400px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      #title {
        color: #fff;
        background-color: #4d90fe;
        font-size: 25px;
        font-weight: 500;
        padding: 6px 12px;
      }
    </style>
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
		  <li><a href="#"><small class="glyphicon glyphicon-plus"></small> Add Admin</a></li>
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
			  				<button class="btn btn-primary push-right" style="width: 100%" data-toggle="modal" data-target="#add-location">
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
			  		<th>ID</th>
			  		<th>Name</th>
			  		<th>Address</th>
			  		<th>Latitude</th>
			  		<th>Longitude</th>
			  		<th>Zone ID</th>
			  		<th>Zone Name</th>
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
	
	<!-- Add Location Modal -->
	<div class="modal fade" id="add-location" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Add Location</h4>
	      </div>
	      <div class="modal-body">
		     <form id="form-add-location" method="post">
		     	<div class="form-group">
					<label>Location Name:</label>
					<input id="name" class="form-control" type="text" name="name">
				</div>
				<div class="form-group">
					<label>Zone:</label>
					<select class="form-control" name="zone"></select>
				</div>
				<div class="form-group">
					<label>Address:</label>
					<input id="address" class="form-control" type="text" name="address">
					
					
					<div class="pac-card" id="pac-card">
				      <div>
				        <div id="title">
				          Location search
				        </div>
				        <div id="type-selector" class="pac-controls">
				          <input type="radio" name="type" id="changetype-all" checked="checked">
				          <label for="changetype-all">All</label>
				
				          <input type="radio" name="type" id="changetype-establishment">
				          <label for="changetype-establishment">Establishments</label>
				
				          <input type="radio" name="type" id="changetype-address">
				          <label for="changetype-address">Addresses</label>
				
				          <input type="radio" name="type" id="changetype-geocode">
				          <label for="changetype-geocode">Geocodes</label>
				        </div>
				        <div id="strict-bounds-selector" class="pac-controls">
				          <input type="checkbox" id="use-strict-bounds" value="">
				          <label for="use-strict-bounds">Strict Bounds</label>
				        </div>
				      </div>
				      <div id="pac-container">
				        <input id="pac-input" type="text"
				            placeholder="Enter a location">
				      </div>
				    </div>
				    <div id="map"></div>
				    <div id="infowindow-content">
				      <img src="" width="16" height="16" id="place-icon">
				      <span id="place-name"  class="title"></span><br>
				      <span id="place-address"></span>
				    </div>
					
				</div>
				<div class="form-group">
					<label>Latitude:</label>
					<input id="latitude" class="form-control" type="text" name="latitude">
				</div>
				<div class="form-group">
					<label>Longitude:</label>
					<input id="longitude" class="form-control" type="text" name="longitude">
				</div>
				<input type="hidden" name="add" value="true">
			</form>
	      </div>
	      <div class="modal-footer">
	      	<div class="row">
	      		<div class="col-md-6"><h5 class="messege text-left"></h5></div>
		      	<div class="col-md-3"><button type="button" class="btn btn-default" style="width: 100%" data-dismiss="modal">Close</button></div>
		      	<div class="col-md-3"><button id="btn-add-location" type="button" style="width: 100%" class="btn btn-primary">Save Location</button></div>
	      	</div>
	      </div>
	    </div>
	  </div>
	</div>
	<script>
      // This example requires the Places library. Include the libraries=places
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

      function initMap() {
    	
    	/** 
    	 * Global variable map
    	 */
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: -33.8688, lng: 151.2195},
          zoom: 13
        });
        var card = document.getElementById('pac-card');
        var input = document.getElementById('pac-input');
        var types = document.getElementById('type-selector');
        var strictBounds = document.getElementById('strict-bounds-selector');

        map.controls[google.maps.ControlPosition.TOP_RIGHT].push(card);

        var autocomplete = new google.maps.places.Autocomplete(input);

        // Bind the map's bounds (viewport) property to the autocomplete object,
        // so that the autocomplete requests use the current map bounds for the
        // bounds option in the request.
        autocomplete.bindTo('bounds', map);

        var infowindow = new google.maps.InfoWindow();
        var infowindowContent = document.getElementById('infowindow-content');
        infowindow.setContent(infowindowContent);
        /**
         * Global Marker
         */
        marker = new google.maps.Marker({
          map: map,
          anchorPoint: new google.maps.Point(0, -29)
        });

        autocomplete.addListener('place_changed', function() {
          infowindow.close();
          marker.setVisible(false);
          place = autocomplete.getPlace();
          if (!place.geometry) {
            // User entered the name of a Place that was not suggested and
            // pressed the Enter key, or the Place Details request failed.
            window.alert("No details available for input: '" + place.name + "'");
            return;
          }

          // If the place has a geometry, then present it on a map.
          if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
          } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);  // Why 17? Because it looks good.
          }
          marker.setPosition(place.geometry.location);
          marker.setVisible(true);
          
          /**
           * @auther Tousif Osman
           * Custom Location Code
           */
          $("#name").val(place.name)
		  $("#address").val(place.formatted_address)
		  $("#latitude").val(place.geometry.location.lat())
		  $("#longitude").val(place.geometry.location.lng())
		  console.log("autocomplete.addListener: Location Found")
		  
          var address = '';
          if (place.address_components) {
            address = [
              (place.address_components[0] && place.address_components[0].short_name || ''),
              (place.address_components[1] && place.address_components[1].short_name || ''),
              (place.address_components[2] && place.address_components[2].short_name || '')
            ].join(' ');
          }

          infowindowContent.children['place-icon'].src = place.icon;
          infowindowContent.children['place-name'].textContent = place.name;
          infowindowContent.children['place-address'].textContent = address;
          infowindow.open(map, marker);
        });

        // Sets a listener on a radio button to change the filter type on Places
        // Autocomplete.
        function setupClickListener(id, types) {
          var radioButton = document.getElementById(id);
          radioButton.addEventListener('click', function() {
            autocomplete.setTypes(types);
          });
        }

        setupClickListener('changetype-all', []);
        setupClickListener('changetype-address', ['address']);
        setupClickListener('changetype-establishment', ['establishment']);
        setupClickListener('changetype-geocode', ['geocode']);

        document.getElementById('use-strict-bounds')
            .addEventListener('click', function() {
              console.log('Checkbox clicked! New state=' + this.checked);
              autocomplete.setOptions({strictBounds: this.checked});
            });
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCCVUhDD0VqRaE4G7pPFH4YkJ6lMLByvYU&libraries=places&callback=initMap" async defer></script>
	<script type="text/javascript" src="js/app.js"></script>
</body>
</html>