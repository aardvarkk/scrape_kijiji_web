window.onload = function() {

	var myLatlng = new google.maps.LatLng(43.5304758, -80.2261559);

	var myOptions = {
		center : myLatlng,
		zoom : 14,
		mapTypeId : google.maps.MapTypeId.ROADMAP
	};

	var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

	// get the listings from the given URL
	data_url = document.getElementById('map_canvas').getAttribute('data-url');

	// draw the overlays once we retrieve the data
	$.getJSON(data_url, function(listings) 
		{ 
			drawOverlays(map, myLatlng, listings); 

			// draw a marker for each listing
			var markers = new Array();
			for (var i = 0; i < listings.length; ++i) {
				markers[i] = new google.maps.Marker({
				position : new google.maps.LatLng(listings[i]['lat'], listings[i]['lon']),
				map : map,
				title : listings[i]['title']
				});
			}
		});
}