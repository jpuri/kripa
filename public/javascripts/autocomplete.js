function populateAutoComplete(entity){
	$.ajax({
	  url : server_url + entity + "/ajaxAutoCompleteValue",
	  success : function(data){
		$( "." + entity + "autocomplete" ).autocomplete({ minLength: 0 });
		$( "." + entity + "autocomplete" ).autocomplete({ delay: 0 });
		$( "." + entity + "autocomplete" ).autocomplete({
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

populateAutoComplete('models')
populateAutoComplete('parts')
