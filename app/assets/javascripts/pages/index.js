function searchSpotify(q) {
	$.get("http://ws.spotify.com/search/1/track.json?q="+q, function(data){	
		$('#results').empty();
		var arr = new Array();
		for (var i=0;i<20;i++) {
			var str = data["tracks"][i]["artists"][0]["name"] + " - " + data["tracks"][i]["name"] + " - " + data["tracks"][i]["album"]["released"];
			arr.push(str);
			// $('#results').append(str);
			// 		$('#results').append('<br/>');
		}
		
		$( "#q" ).autocomplete({
			source: arr
		});
	});
}