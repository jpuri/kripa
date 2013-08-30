server_url = 'http://obscure-atoll-7710.herokuapp.com/'
//server_url = 'http://localhost:3000/'

$(document).ready(function() {
	
	$('#priceMegaMenuDiv').live('mouseleave', function(e){
		hidePriceMenuDiv()
	})
	$('#adminMegaMenuDiv').live('mouseleave', function(e){
		hideAdminMenuDiv()
	})
	$('#priceMenuDiv').live('mouseleave', function(e){
		if(e.toElement.id != 'priceMegaMenuDiv')
			hidePriceMenuDiv()
	})
	$('#adminMenuDiv').live('mouseleave', function(e){
		if(e.toElement.id != 'adminMegaMenuDiv')
			hideAdminMenuDiv()
	})
	$(document).ajaxError(function(event, jqXHR, settings, throwError){
	    if(jqXHR.status=='500'){
	        window.location = server_url
	    }
	});
});


function showPriceMenuDiv(){
	hideAdminMenuDivImmediate()
	el = document.getElementById("priceMegaMenuDiv");
	el.style.visibility = "visible";
}

function showAdminMenuDiv(){
	hidePriceMenuDivImmediate()
	el = document.getElementById("adminMegaMenuDiv");
	el.style.visibility = "visible";
}
	
function hidePriceMenuDiv(timeout){
	if(!timeout)
		timeout = 4000
	setTimeout(function () { 
		el = document.getElementById("priceMegaMenuDiv");
		el.style.visibility = "hidden" 
	}, timeout);
}

function hidePriceMenuDivImmediate(){
		el = document.getElementById("priceMegaMenuDiv");
		el.style.visibility = "hidden" 
}

function hideAdminMenuDivImmediate(){
		el = document.getElementById("adminMegaMenuDiv");
		el.style.visibility = "hidden" 
}

function hideAdminMenuDiv(timeout){
	if(!timeout)
		timeout = 4000
	setTimeout(function () { 
	el = document.getElementById("adminMegaMenuDiv");
	el.style.visibility = "hidden" 
		}, timeout);
}

$(".decimal_places2").live('blur', function() {
    var value = $(this).val()
    if(value){
    $(this).val($.number(value, 2, '.', ''));
    $(this).trigger("twoDecimalPlaces_changed")
    }

})

$("#user_mgt_link").live('click', function(){
	$http.get('users')
})
