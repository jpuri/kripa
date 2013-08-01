//server_url = 'http://obscure-atoll-7710.herokuapp.com/'
server_url = 'http://localhost:3000/'

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
	$('#priceMenuDivMain').live('mouseleave', function(e){
		hidePriceMenuDiv()
	})
	$('#adminMenuDivMain').live('mouseleave', function(e){
		hideAdminMenuDiv()
	})
	$('#priceMenuDiv').live('mouseleave', function(e){
		if(e.toElement.id != 'priceMenuDivMain')
			hidePriceMenuDiv()
	})
	$('#adminMenuDiv').live('mouseleave', function(e){
		if(e.toElement.id != 'adminMenuDivMain')
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
    $.ajax({
      url : server_url + "part_prices/ajaxPartPriceMenu",
	  data : {},
      success : function(html){
		$("#priceMenuDivMain").html(html)
		el = document.getElementById("priceMenuDivMain");
		el.style.visibility = "visible";
      }
	})
}

function showAdminMenuDiv(){
	hidePriceMenuDivImmediate()
	el = document.getElementById("adminMenuDivMain");
	el.style.visibility = "visible";
}
	
function hidePriceMenuDiv(timeout){
	if(!timeout)
		timeout = 4000
	setTimeout(function () { 
		el = document.getElementById("priceMenuDivMain");
		el.style.visibility = "hidden" 
	}, timeout);
}

function hidePriceMenuDivImmediate(){
		el = document.getElementById("priceMenuDivMain");
		el.style.visibility = "hidden" 
}

function hideAdminMenuDivImmediate(){
		el = document.getElementById("adminMenuDivMain");
		el.style.visibility = "hidden" 
}

function hideAdminMenuDiv(timeout){
	if(!timeout)
		timeout = 4000
	setTimeout(function () { 
	el = document.getElementById("adminMenuDivMain");
	el.style.visibility = "hidden" 
		}, timeout);
}

function searchPartPrice(make, currency){
	$('#make').val(make)
	$('#currency').val(currency)
	$('#partPriceSearchForm').submit()
}

$(".decimal_places2").live('blur', function() {
    var value = $(this).val()
    if(value){
    $(this).val($.number(value, 2, '.', ''));
    $(this).trigger("twoDecimalPlaces_changed")
    }

})

$("#user_mgt_link").live('click', function(){
	window.location = server_url + "users"
})
