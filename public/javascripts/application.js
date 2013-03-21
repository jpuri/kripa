// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var server_url = 'http://obscure-atoll-7710.herokuapp.com/'
//var server_url = 'http://localhost:3000/'

function addPartToBill(){
  calculatePartDetails()
  addPartsWeightPrice()
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
		discount: $('#part_discount').val()},
    success : function(data){
	  var total_weight = parseFloat($('#totalweight').text()) + parseFloat(data.weight)
	  var total_price = parseFloat($('#totalprice').text()) + parseFloat(data.price)
	  $('#totalweight').text(total_weight)
	  $('#bill_total_weight').val(total_weight)
	  $('#totalprice').text(total_price)
	  $('#bill_total_price').val(total_price)
    }
  })
}

$(document).ready(function() {
  $('#bill_part_id').change(function(){
    getPartDetails()
  })
  $('.remove_image').live("click", function(){
    $(this).parent().remove()
  })
});

function getPartDetails(){
  $.ajax({
    url : server_url + "bills/getPartDetails",
    type : "get",
	data : {part_id: $('#bill_part_id').val(),
		customer_id: $('#bill_customer_id').val(),
		currency_id: $('#bill_currency_id').val()},
    success : function(data){
      $('#part_name').val(data.part_name)
      $('#part_price').val(data.part_price)
      $('#part_weight').val(data.part_weight)
    }
  })
  return false;
}

function clearGenerateBillPage(){
  if(confirm('Are you sure you want to clear page ?')){
    $('#bill_customer_id').val("") 
    $('#bill_part_id').val("") 
    $('#bill_model_id').val("") 
    $('#bill_currency_id').val("")
    $('#quantity').val("")
    $('#addedPart').html("")
    $('#totalweight').text(0.0)
    $('#totalprice').text(0.0)
  }
  return false;
}

function removeUpdate(weight, price){
  $('#totalweight').text(parseFloat($('#totalweight').text()) - parseFloat(weight))
  $('#totalprice').text(parseFloat($('#totalprice').text()) - parseFloat(price))
  return false;
}

function show(path, id){
	window.location = '/' + path + '/' + id
}
