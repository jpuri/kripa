function Base(entity, search){
	this.entity = entity
	this.search = search
}

Base.prototype = {

//to be modified for search form 
  	searchEntity : function() {
		Base = this  		
		entity = Base.entity
		search = Base.search
		if(search)
			data = Base.getSearchParams()
		else
			data = {}
		Base.clearMessages()
		Base.showSpinner("spinner_search")
    	$.ajax({
      		url : server_url + entity + "/ajaxSearch",
      		data : data,
      		success : function(html){
				Base.showDataInDiv("results", html)
				Base.hideSpinner("spinner_search")
      		}
		})
	},
	
	newEntity : function(){
		Base = this  		
		entity = Base.entity
		Base.showSpinner("spinner_new")
	    $.ajax({
	      url : server_url + entity + "/ajaxNew",
	      success : function(html){
			Base.hideSpinner("spinner_new")
			Base.showDialog("dialog_create", html)
	      }
		})
	},
	
	createEntity : function(){
		Base = this  		
		entity = Base.entity
		Base.clearMessages()
		Base.showSpinner('spinner_create')
	    $.ajax({
	      url : server_url + entity + "/ajaxCreate",
		  data : $("#createForm").serialize(),
	      success : function(response){
	      	if(response.status == 'SUCCESS'){
	      		Base.searchEntity()
	  			Base.showSuccessMessage("Successfully created.")
	  		}
	      	else if(response.status == 'FAILURE'){
	  			Base.showFailureMessage("Error while creating.")
	  		}
			Base.closeDialog('dialog_create')
	      }
	      //failure to be done
		})
	},
	
	editEntity : function(id, index){
		Base = this  		
		entity = Base.entity
		if(!index)
			index = id
		Base.showSpinner('spinner_edit_' + index)
	    $.ajax({
	      url : server_url + entity + "/ajaxEdit",
		  data : {
		  	id: id
		  },
	      success : function(html){
			Base.hideSpinner('spinner_edit_' + index)
			Base.showDialog("dialog_update", html)
	      }
		})
	},
	
	deleteEntity : function(id, index) {
		Base = this  		
		entity = Base.entity
		search = Base.search
		if(!index)
			index = id
		Base.clearMessages()
		if(confirm('Are you sure you want to delete ?')){
		    Base.showSpinner('spinner_delete_' + index)
		    $.ajax({
		    	url : server_url + entity + "/ajaxDelete",
				data : {
					id: id
				},
			    success : function(response){
			    	if(response.status == 'SUCCESS'){
			      		if(entity == 'prices')
			  				Base.searchEntity()
			  			else
			      			$("#" + entity + '_' + id).remove()
			  			Base.showSuccessMessage("Successfully deleted.")
			  		}
			      	else if(response.status == 'FAILURE'){
			  			Base.showFailureMessage("Error while deleting.")
			  		}
			    }
			})
		  }
		  return false;
	},
	
	updateEntity : function (id){
		Base = this  		
		entity = Base.entity
		search = Base.search
		Base.clearMessages()
		Base.showSpinner('spinner_update')
	    $.ajax({
	      url : server_url + entity + "/ajaxUpdate",
		  data : $("#updateForm").serialize(),
	      success : function(response){
	      	if(response.status == 'SUCCESS'){
	      		if(!search)
	  				Base.updateDisplayValues(response.displayValue, id)
	  			else
	  				Base.searchEntity()
				Base.showSuccessMessage("Successfully updated.")
	  		}
	      	else if(response.status == 'FAILURE'){
	  			Base.showFailureMessage("Error while updating.")
	  		}
			Base.closeDialog('dialog_update')
	      }
	      //failure to be done
		})
	},
	
	updateDisplayValues : function(displayValue, id){
		for(i = 0; i < displayValue.length;i++)
			$("#" + entity + '_' + id + '_' + i).html(displayValue[i])
	},

	showSuccessMessage : function(msg){
		$("#success_msg").html(msg)
	},
	
	showFailureMessage : function(msg){
		$("#failure_msg").html(msg)
	},
	
	closeDialog : function(divId){
		$('#' + divId).dialog("close")
	},
	
	showDialog : function(div, html){
	  Base.showDataInDiv(div, html);
	  $("#"+div).dialog("open");
	},
	
	showDataInDiv : function(div, data){
	  $("#"+div).html(data);
	},
	
	showSpinner : function(div){
		$('#' + div).show()	
	},

	hideSpinner : function(div){
		$('#' + div).hide()	
	},
	
	clearMessages : function(){
		$("#success_msg").html('')
		$("#failure_msg").html('')
	}
}

Part = new Base('parts', false)
Price = new Base('prices', true)
Model = new Base('models', false)
Make = new Base('makes', false)
Customer = new Base('customers', false)
PartPrice = new Base('part_prices', true)

Price.getSearchParams = function() {
	return {
		'make_id' : $('#make_id').val(),
		'model_number' : $('#model_number').val(),
		'part_number' : $('#part_number').val(),
		'customer_id' : $('#customer_id').val(),
		'currency_id' : $('#currency_id').val(),
	}
}

Price.resetSearchFields = function() {
	$('#make_id').val('')
	$('#model_id').val('')
	$('#part_id').val('')
	$('#customer_id').val('')
	$('#currency_id').val('')
}

PartPrice.getSearchParams = function() {
	return {
		'make' : $('#part_price_make').val(),
		'model' : $('#model').val(),
		'part_number' : $('#part_number').val(),
		'currency' : $('#part_price_currency').val(),
	}
}

PartPrice.resetSearchFields = function() {
	PartPrice.clearMessages()
	$('#make').val('')
	$('#model').val('')
	$('#part_number').val('')
	$('#currency').val('')
}

PartPrice.newEntity = function(){
	Base = this  		
	entity = Base.entity
	Base.clearMessages()
	Base.showSpinner("spinner_new")
    $.ajax({
      url : server_url + entity + "/ajaxNew",
      success : function(html){
		Base.hideSpinner("spinner_new")
		$("#createNewRow").show()
		$("#createNewRow").html(html)
      }
	})
}

PartPrice.hideCreateRow = function(){
	$("#createNewRow").html('')
}

PartPrice.createEntity = function(){
		Base = this  		
		entity = Base.entity
		Base.clearMessages()
		Base.showSpinner('spinner_create')
	    $.ajax({
	      url : server_url + entity + "/ajaxCreate",
		  data : {
					'part_price[make]': $('#part_price_make').val(),
					'part_price[model]': $('#part_price_model').val(),
					'part_price[part_number]': $('#part_price_part_number').val(),
					'part_price[part_desc]': $('#part_price_part_desc').val(),
					'part_price[weight]': $('#part_price_weight').val(),
					'part_price[currency]': $('#part_price_currency').val(),
					'part_price[price]': $('#part_price_price').val()
				},
	      success : function(response){
	      	if(response.status == 'SUCCESS'){
	      		Base.searchEntity()
	  			Base.showSuccessMessage("Successfully created.")
				$("#createNewRow").hide()
	  		}
	      	else if(response.status == 'FAILURE'){
	  			Base.showFailureMessage("Error while creating.")
	  		}
			Base.hideSpinner('spinner_create')
	      }
	      //failure to be done
		})
	}
	
PartPrice.updateEntity = function (id, index){
		Base = this  		
		entity = Base.entity
		search = Base.search
		Base.clearMessages()
		Base.showSpinner('spinner_update')
	    $.ajax({
	      url : server_url + entity + "/ajaxUpdate",
		  data : {
					'id': id,
					'part_price[make]': $('#part_price_make').val(),
					'part_price[model]': $('#part_price_model').val(),
					'part_price[part_number]': $('#part_price_part_number').val(),
					'part_price[part_desc]': $('#part_price_part_desc').val(),
					'part_price[weight]': $('#part_price_weight').val(),
					'part_price[currency]': $('#part_price_currency').val(),
					'part_price[price]': $('#part_price_price').val()
				},
	      success : function(response){
	      	if(response.status == 'SUCCESS'){
	      		Base.showEntityInRow(id, index)
				Base.showSuccessMessage("Successfully updated.")
	  		}
	      	else if(response.status == 'FAILURE'){
	  			Base.showFailureMessage("Error while updating.")
	  		}
			Base.hideSpinner('spinner_update')
	      }
	      //failure to be done
		})
	}
	
PartPrice.editEntity = function(id, index){
		Base = this  		
		entity = Base.entity
		if(!index)
			index = id
		Base.showSpinner('spinner_edit_' + index)
		Base.clearMessages()
	    $.ajax({
	      url : server_url + entity + "/ajaxEdit",
		  data : {
		  	id: id,
		  	index: index
		  },
	      success : function(html){
			Base.hideSpinner('spinner_edit_' + index)
			$("#" + entity + '_' + id).html(html)
	      }
		})
	}
	
PartPrice.showEntityInRow = function(id, index){
    $.ajax({
      url : server_url + entity + "/ajaxSingleDisplayRow",
	  data : {
	  	id: id,
	  	index: index
	  },
      success : function(html){
		$("#" + entity + '_' + id).html(html)
      }
    })
}	