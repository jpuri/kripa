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

