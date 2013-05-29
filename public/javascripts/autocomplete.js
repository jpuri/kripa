function populatePartsAutoComplete(){
	$.ajax({
	  url : server_url + "parts/ajaxAutoCompleteValue",
	  data: {model_number: $('#model_number').val()},
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
	  url : server_url + "models/ajaxAutoCompleteValue",
	  data: {make_id: $('#make_id').val()},
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
	$(".search_make").change(function(event) {
	  $(".search_model").val('')
	  $(".search_part").val('')
	});
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