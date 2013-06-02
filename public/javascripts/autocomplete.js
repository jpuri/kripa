function populatePartsAutoComplete(){
	$.ajax({
	  url : server_url + "part_prices/ajaxAutoCompleteParts",
	  data: {model_number: $('#model').val(),
	  currency: $('#part_price_currency').val()},
	  success : function(data){
		$( ".search_part" ).autocomplete({ minLength: 0 });
		$( ".search_part" ).autocomplete({ delay: 0 });
		$( ".search_part" ).autocomplete({
		  	source: function( request, response ) {
	          var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
	          response( $.grep( data.list, function( item ){
	              return matcher.test( item );
	          }) );
		    }
		});
	  }
	})
}

function populateModelsAutoComplete(){
	$.ajax({
	  url : server_url + "part_prices/ajaxAutoCompleteModels",
	  data: {make: $('#part_price_make').val(),
	  currency: $('#part_price_currency').val()},
	  success : function(data){
		$( ".search_model" ).autocomplete({ minLength: 0 });
		$( ".search_model" ).autocomplete({ delay: 0 });
		$( ".search_model" ).autocomplete({
		  	source: function( request, response ) {
	          var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" );
	          response( $.grep( data.list, function( item ){
	              return matcher.test( item );
	          }) );
		    }
		});
	  }
	})
}

$(document).ready(function() {
	$(".search_model").change(function() {
	  $(".search_part").val('')
	});
	$(".search_model").focusin(function() {
	  populateModelsAutoComplete();
	});
	$(".search_part").focusin(function() {
	  populatePartsAutoComplete();
	});
})