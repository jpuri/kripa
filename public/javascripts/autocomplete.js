function populatePartsAutoComplete(data, textBoxClass){
	$.ajax({
	  url : server_url + "part_prices/ajaxAutoCompleteParts",
	  data: data,
	  success : function(data){
		$( "." + textBoxClass ).autocomplete({ minLength: 0 });
		$( "." + textBoxClass ).autocomplete({ delay: 0 });
		$( "." + textBoxClass ).autocomplete({
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

function populateModelsAutoComplete(data, textBoxClass){
	$.ajax({
	  url : server_url + "part_prices/ajaxAutoCompleteModels",
	  data: data,
	  success : function(data){
		$( "." + textBoxClass ).autocomplete({ minLength: 0 });
		$( "." + textBoxClass ).autocomplete({ delay: 0 });
		$( "." + textBoxClass ).autocomplete({
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
	  var data = {make: $('#part_price_make').val(),
	  currency: $('#part_price_currency').val()}
	  populateModelsAutoComplete(data, "search_model");
	});
	$(".search_part").focusin(function() {
	  var data = {model_number: $('#model').val(),
	  currency: $('#part_price_currency').val(),
	  make: $('#part_price_make').val()}
	  populatePartsAutoComplete(data, "search_part");
	});
})