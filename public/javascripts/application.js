$(document).ready(function() {
	
	$('#priceMegaMenuDiv').live('mouseleave', function(e){
		hidePriceMenuDiv()
	})
	$('#priceMenuDiv').live('mouseleave', function(e){
		if(e.toElement.id != 'priceMegaMenuDiv')
			hidePriceMenuDiv()
	})
});


function showPriceMenuDiv(){
	el = document.getElementById("priceMegaMenuDiv");
	el.style.visibility = "visible";
}

function showAdminMenuDiv(){
	hidePriceMenuDivImmediate()
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


//ng-mouseleave