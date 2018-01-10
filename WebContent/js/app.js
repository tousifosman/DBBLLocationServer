function editLocation(e){
	locationFlag = "edit"
	console.log(e)
	$("#add-location").modal()
	var tds = $(e).find("td");
	tdsx = tds
	var lat = tds[3].innerHTML;
	var lng = tds[4].innerHTML;
	
	$("#name").val(tds[1].innerHTML);	
	$("#address").val(tds[2].innerHTML);	
	$("#latitude").val(lat);	
	$("#longitude").val(lng);
	//console.log($("#form-add-location select option"))
	//$("#form-add-location select").val(tdsx[5].innerText)
	
	selectedZoneId = tdsx[5].innerText
	selectedLocationId = tdsx[0].innerText
	
	var latLng = new google.maps.LatLng(lat, lng);
	
	marker.setPosition(latLng)
	map.setCenter(latLng);
    map.setZoom(17);
	$("#pac-input").val(tds[1].innerHTML)
}
window.addEventListener("load", function() {
	function updateLocations() {
		$.getJSON('Locations', {get: 'all'}, function(data){
	    	var locationHTML = "";
	    	for(var i in data) {
	    		locationHTML += '<tr data-id="'+data[i].id+'" onclick="editLocation(this)">'
	    			+ '<td>'+data[i].id+'</td>'
	    			+ '<td>'+data[i].name + '</td>'
	    			+ '<td>'+data[i].address + '</td>'
	    			+ '<td>'+data[i].latitude + '</td>'
	    			+ '<td>'+data[i].longitude + '</td>'
	    			+ '<td>'+data[i].zone + '</td>'
	    			+ '<td>'+data[i].zone_name + '</td>'
	    			+ '</tr>';
	    	}
	    	$("#user_table tbody")[0].innerHTML = locationHTML
		})
	}
	updateLocations();
	$(".modal.fade").on("hidden.bs.modal", function () {
		updateLocations();
		locationFlag = ""
	});
	
	$(".modal.fade").on('shown.bs.modal', function () {
	
	});
	$("#add-zone-button").click(function() {
		$.post('Zones', {add: true, name: $("#add-zone form input[name=name]").val()}, "json")
			.done(function(result) {
				if( result.trim() == 'success' ) {
					$("#add-zone .messege")
						.removeClass("text-danger")
						.addClass("text-success")
						.html('success <i class="glyphicon glyphicon-ok"></i>');
				} else {
					$("#add-zone .messege")
						.removeClass("text-success")
						.addClass("text-danger")
						.html('Failed <i class="glyphicon glyphicon-remove"></i>');
				};
			});
	});
	
	$("#delete-zone").on('shown.bs.modal', function(){
	    $.getJSON('Zones', {get: 'all'}, function(data){
	    	var zoneHTML = "";
	    	for(var i in data) {
	    		zoneHTML += '<tr><td data-id="'+data[i].id+'">'+data[i].name+'</td></tr>';
	    	}
	    	//$("#delete-zone-table tbody *").remove()
	    	$("#delete-zone-table tbody")[0].innerHTML = zoneHTML;
	    	$("#delete-zone-table tbody td").click(function(){
	    		var deleteZoneTd = this;
	    		$.post('Zones', {'delete': this.dataset.id}, "JSON")
	    			.done(function(result) {
	    				if( result.trim() == 'success' ) {
	    					$("#delete-zone .messege")
	    						.removeClass("text-danger")
	    						.addClass("text-success")
	    						.html('success <i class="glyphicon glyphicon-ok"></i>');
	    					deleteZoneTd.remove();
	    				} else {
	    					$("#delete-zone .messege")
	    						.removeClass("text-success")
	    						.addClass("text-danger")
	    						.html('Failed <i class="glyphicon glyphicon-remove"></i>');
	    				};
	    			})
	    	})
	    });
	});
	
	
	$("#add-location").on('shown.bs.modal', function(){
		google.maps.event.trigger(map, 'resize');
		$.getJSON('Zones', {get: 'all'}, function(data){
	    	var zoneHTML = "";
	    	for(var i in data) {
	    		zoneHTML += '<option value="'+data[i].id+'">'+data[i].name+'</option>';
	    	}
	    	$("#add-location select").html(zoneHTML);
	    	if (locationFlag == "edit")
	    		$("#form-add-location select").val(selectedZoneId)
		})
	})
	
	$("#btn-add-location").click(function(){
		var data = {}
		$("#form-add-location").serializeArray().map(function(x){
			data[x.name] = x.value;
		});
		if (locationFlag == "edit") {
			data["update"] = true
			data["id"] = selectedLocationId
		}
		$.post("Locations", data, "JSON")
			.done(function(result) {
				if( result.trim() == 'success' ) {
					$("#add-location .messege")
						.removeClass("text-danger")
						.addClass("text-success")
						.html('success <i class="glyphicon glyphicon-ok"></i>');
					//deleteZoneTd.remove();
				} else {
					$("#add-location .messege")
						.removeClass("text-success")
						.addClass("text-danger")
						.html('Failed <i class="glyphicon glyphicon-remove"></i>');
				};
			})
	})
	
	
})