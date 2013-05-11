server_url = 'http://obscure-atoll-7710.herokuapp.com/'
//server_url = 'http://localhost:3000/'

$(document).ready(function() {
	  $(".popup").dialog({
	    autoOpen : false,
		width : 350,
		height : 350,
		modal : true
	});
	  $(".large-popup").dialog({
	    autoOpen : false,
		width : 400,
		height : 450,
		modal : true
	});
	
});

$(document).ajaxError(function(event, jqXHR, settings, throwError){
    if(jqXHR.status=='408'){
        window.location = server_url
    }
});

