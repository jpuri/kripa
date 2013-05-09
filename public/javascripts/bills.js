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

/*  $('#bill_part_id').change(function(){
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
  })*/

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