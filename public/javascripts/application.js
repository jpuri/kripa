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
	$('#priceMenuDivMain').live('mouseleave', function(e){
		hidePriceMenuDiv()
	})
	$('#priceMenuDiv').live('mouseleave', function(e){
		if(e.toElement.id != 'priceMenuDivMain')
			hidePriceMenuDiv()
	})
	$(document).ajaxError(function(event, jqXHR, settings, throwError){
	    if(jqXHR.status=='500'){
	        window.location = server_url
	    }
	});
});


function showPriceMenuDiv(){
    $.ajax({
      url : server_url + "part_prices/ajaxPartPriceMenu",
	  data : {
	  },
      success : function(html){
		$("#priceMenuDivMain").html(html)
		el = document.getElementById("priceMenuDivMain");
		el.style.visibility = "visible";
      }
	})
}
	
function hidePriceMenuDiv(){
	el = document.getElementById("priceMenuDivMain");
	el.style.visibility = "hidden" 
}

function searchPartPrice(make, currency){
	$('#make').val(make)
	$('#currency').val(currency)
	$('#partPriceSearchForm').submit()
}