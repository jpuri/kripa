var Base = {
	server_url : 'http://obscure-atoll-7710.herokuapp.com/'
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
	  			Base.setSuccessMessage("Successfully created.")
	  		}
	      	else if(response.status == 'FAILURE'){
	  			Base.setFailureMessage("Error while creating.")
	  		}
			Base.closeDialog('dialog_create')
	      }
	      //failure to be done
		})
	},
	
	editEntity : function(id){
		entity = this.entity
		server_url = this.server_url
		$("#spinner_edit_" + id).show()
	    $.ajax({
	      url : server_url + entity + "/ajaxEdit",
		  data : {
		  	id: id
		  },
	      success : function(html){
			$("#spinner_edit_"+id).hide()
			showPopUp("dialog_update", html)
	      }
		})
	},
	
	setSuccessMessage : function(msg){
		$("#success_msg").html(msg)
	},
	
	setFailureMessage : function(msg){
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
	}
}

function Model(entity){
	this.entity = entity
}
Model.prototype = Base
Part = new Model('parts')

var server_url = Base.server_url

function addPartToBill(){
  showSpinner()
  calculatePartDetails()
  addPartsWeightPrice()
  resetPartValues()
  hideSpinner()
  return false;
}

function calculatePartDetails(){
    $.ajax({
      url : server_url + "bills/calculatePartDetails",
      type : "get",
	  data : {part_id: $('#bill_part_id').val(),
		customer_id: $('#bill_customer_id').val(),
		currency_id: $('#bill_currency_id').val(),
		quantity: $('#part_quantity').val(),
		discount: $('#part_discount').val()},
      success : function(html){
		$('#addedPart').append(html)
    }
  })
}

function addPartsWeightPrice(){  
  $.ajax({
    url : server_url + "bills/getWeigthPrice",
    type : "get",
	data : {part_id: $('#bill_part_id').val(),
		customer_id: $('#bill_customer_id').val(),
		currency_id: $('#bill_currency_id').val(),
		quantity: $('#part_quantity').val(),
		discount: $('#part_discount').val(),
		bill_total_price: $('#bill_total_price').val(),
		bill_total_weight: $('#bill_total_weight').val()},
    success : function(data){
	  $('#totalweight').text(data.bill_total_weight)
	  $('#bill_total_weight').val(data.bill_total_weight)
	  $('#totalprice').text(data.bill_total_price)
	  $('#bill_total_price').val(data.bill_total_price)
    }
  })
}

function resetPartValues(){
  $('#part_description').val('')
  $('#part_price').val('')
  $('#part_weight').val('')
  $('#part_quantity').val('1')
  $('#part_discount').val('0')
}

$(document).ready(function() {
  $('#bill_part_id').change(function(){
    getPartDetails()
  })
  $('#bill_currency_id').change(function(){
    getPartDetails()
  })
  $('#bill_customer_id').change(function(){
    getPartDetails()
  })
  $('.remove_image').live("click", function(){
    $(this).parent().remove()
  })
});

function validate(){
	var returnValue = true
	if($('#bill_part_id').val().length <= 0){
	  returnValue = false
	}
	if($('#bill_currency_id').val().length <= 0){
	  returnValue = false
	}
	if($('#bill_customer_id').val().length <= 0){
	  returnValue = false
	}
	return returnValue
}

function getPartDetails(){
  if(validate()){
    showSpinner()
    resetPartValues()
    $('#message').html('')
    $.ajax({
      url : server_url + "bills/getPartDetails",
      type : "get",
	  data : {part_id: $('#bill_part_id').val(),
		customer_id: $('#bill_customer_id').val(),
		currency_id: $('#bill_currency_id').val()},
      success : function(response){
      	if(response.status === 'success'){
      	  var data = response.data
          $('#part_description').val(data.part_description)
          $('#part_price').val(data.part_price)
          $('#part_weight').val(data.part_weight)
        }else{
		  $('#message').append('<font color="red">' + response.message + '</font>')
        }
        hideSpinner()
      }
    })
  }
  return false
}

function clearGenerateBillPage(){
  if(confirm('Are you sure you want to clear page ?')){
  	window.location = '/bills/new'
  }
  return false;
}

function removeUpdate(weight, price){
  $('#totalweight').text(parseFloat($('#totalweight').text()) - parseFloat(weight))
  $('#totalprice').text(parseFloat($('#totalprice').text()) - parseFloat(price))
  return false;
}

function openPage(entity, id, action){
	var path = '/' + entity
	if(id)
	  path += '/' + id
	if(action)
	  path += '/' + action
	window.location = path
}

function showSpinner() {
    $("#spinner").show()
}

function hideSpinner() {
    $("#spinner").hide()
}

function setExportFlag(){
    $("#export_flag").val("true")
    return true
}

function showPopUp(popupdiv, html){
  $("#" + popupdiv).html(html);
  $("#" + popupdiv).dialog("open");
}

function deletePart(part_id, part_no) {
  if(confirm('Are you sure you want to delete Part ' + part_no + ' ?')){
	cleanMessages()
    $("#spinner_delete_"+part_id).show()
    $.ajax({
      url : server_url + "parts/ajaxDelete",
      type : "get",
	  data : {
	  	part_id: part_id
	  },
      success : function(response){
      	if(response.status == 'SUCCESS'){
      		$("#part_"+part_id).remove()
  			$("#success_msg").html("Part successfully deleted.")
  		}
      	else if(response.status == 'FAILURE'){
  			$("#failure_msg").html("Error while deleting part.")
  		}
      }
	})
  }
  return false;
}

function updatePart(part_id){
	cleanMessages()
	$("#spinner_save").show()
    $.ajax({
      url : server_url + "parts/ajaxUpdate",
      type : "get",
	  data : $("#updatePartForm").serialize(),
      success : function(response){
      	if(response.status == 'SUCCESS'){
		$("#part_number_" + part_id).html(response.part.part.number);
		$("#part_description_" + part_id).html(response.part.part.description);
		$("#part_weight_" + part_id).html(response.part.part.weight);
		$("#part_models_" + part_id).html(response.modelNumbers);
  		$("#success_msg").html("Part successfully updated.")
  		}
      	else if(response.status == 'FAILURE'){
  			$("#failure_msg").html("Error while updating part.")
  		}
		$("#dialog_update").dialog("close")
      }
      //failure to be done
	})
}

function cleanMessages(){
	$("#success_msg").html('')
	$("#failure_msg").html('')
}

function closeDialog(divId){
		$("#" + divId).dialog("close")
}
