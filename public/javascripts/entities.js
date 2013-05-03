function Base(entity, search){
	this.entity = entity
	this.search = search
}

Base.prototype = {

  	searchEntity : function(resultDiv) {
		Base = this  		
		entity = Base.entity
    	$.ajax({
      		url : server_url + entity + "/ajaxIndex",
      		success : function(html){
				Base.showDataInDiv(resultDiv, html)
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
	
	createEntity : function(resultDiv){
		Base = this  		
		entity = Base.entity
		Base.clearMessages()
		Base.showSpinner('spinner_create')
	    $.ajax({
	      url : server_url + entity + "/ajaxCreate",
		  data : $("#createForm").serialize(),
	      success : function(response){
	      	if(response.status == 'SUCCESS'){
	      		Base.searchEntity(resultDiv)
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
	
	editEntity : function(id){
		Base = this  		
		entity = Base.entity
		Base.showSpinner('spinner_edit_' + id)
	    $.ajax({
	      url : server_url + entity + "/ajaxEdit",
		  data : {
		  	id: id
		  },
	      success : function(html){
			Base.hideSpinner('spinner_edit_' + id)
			Base.showDialog("dialog_update", html)
	      }
		})
	},
	
	deleteEntity : function(id) {
		Base = this  		
		entity = Base.entity
		if(confirm('Are you sure you want to delete ?')){
			Base.clearMessages()
		    Base.showSpinner('spinner_delete_' + id)
		    $.ajax({
		    	url : server_url + entity + "/ajaxDelete",
				data : {
					id: id
				},
			    success : function(response){
			    	if(response.status == 'SUCCESS'){
			      		$("#part_"+id).remove()
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
				Base.showSuccessMessage("Part successfully updated.")
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
			$("#part_" + id + '_' + i).html(displayValue[i])
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