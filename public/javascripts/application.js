var Base = {
	server_url : 'http://obscure-atoll-7710.herokuapp.com/',
  	//server_url : 'http://localhost:3000/',

  	searchEntity : function(resultDiv) {
		entity = this.entity
		server_url = this.server_url
    	$.ajax({
      		url : server_url + entity + "/ajaxIndex",
      		success : function(html){
				Base.showDataInDiv(resultDiv, html)
      		}
		})
	},

	newEntity : function(){
		entity = this.entity
		server_url = this.server_url
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
		entity = this.entity
		server_url = this.server_url
		cleanMessages()
		showSpinner('spinner_create')
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
		entity = this.entity
		server_url = this.server_url
		showSpinner('spinner_edit_' + id)
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
		entity = this.entity
		server_url = this.server_url
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
		entity = this.entity
		server_url = this.server_url
		this.clearMessages()
		this.showSpinner('spinner_update')
		postUpdate = this.postUpdate
	    $.ajax({
	      url : server_url + entity + "/ajaxUpdate",
		  data : $("#updateForm").serialize(),
	      success : function(response){
	      	if(response.status == 'SUCCESS'){
	  			postUpdate(response, id)
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

$(document).ready(function() {
	  $(".popup").dialog({
	    autoOpen : false,
		width : 350,
		height : 350,
		modal : true
	});
});

function openPage(entity, id, action){
	var path = '/' + entity
	if(id)
	  path += '/' + id
	if(action)
	  path += '/' + action
	window.location = path
}


