window.addEventListener("load", function() {
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
	    });
	});
	
})