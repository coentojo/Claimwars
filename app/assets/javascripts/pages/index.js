function searchSpotify(q) {
	$.get("http://ws.spotify.com/search/1/track.json?q="+q, function(data){	
		$('#results').empty();	
		for (var i=0;i<20;i++) {
			$('#results').append(data["tracks"][i]["artists"][0]["name"]);
			$('#results').append('<br/>');
		}
	});
}