function populatePartsAutoComplete(){
	$.ajax({
	  url : server_url + "parts/ajaxAutoCompleteValue",
	  data: {model_number: $('#model_number').val()},
	  success : function(data){
		$( ".partsautocomplete" ).autocomplete({ minLength: 0 });
		$( ".partsautocomplete" ).autocomplete({ delay: 0 });
		$( ".partsautocomplete" ).autocomplete({
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
	  url : server_url + "models/ajaxAutoCompleteValue",
	  data: {make_id: $('#make_id').val()},
	  success : function(data){
		$( ".modelsautocomplete" ).autocomplete({ minLength: 0 });
		$( ".modelsautocomplete" ).autocomplete({ delay: 0 });
		$( ".modelsautocomplete" ).autocomplete({
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


function clearPartNumber(){
	$('#part_number').val('')
}
function clearPartModelNumber(){
	$('#part_number').val('')
	$('#model_number').val('')
}