server_url : 'http://obscure-atoll-7710.herokuapp.com/'
//server_url : 'http://localhost:3000/'

$(document).ready(function() {
	  $(".popup").dialog({
	    autoOpen : false,
		width : 350,
		height : 350,
		modal : true
	});
});

//to be removed
function openPage(entity, id, action){
	var path = '/' + entity
	if(id)
	  path += '/' + id
	if(action)
	  path += '/' + action
	window.location = path
}


