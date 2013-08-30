function PartPriceCtrl($scope, $http, $routeParams, GenericService) {
  $scope.backupData = {}
  $scope.make = $routeParams.make
  $scope.currency = $routeParams.currency
  
  $http.get('part_prices?make=' + $scope.make + "&currency=" + $scope.currency).success(function(data) {
    $scope.part_prices = data;
    angular.forEach($scope.part_prices, function(part_price){
      $scope.backupPartPriceData(part_price)
    });
  });

  $scope.resetSortParams = function(){
    $scope.sort = "part_number"
    $scope.order = false
  }
  
  $scope.backupPartPriceData = function(part_price){
    $scope.backupData[part_price.id] = {
      model: part_price.model, 
	  part_number: part_price.part_number, 
	  part_desc: part_price.part_desc, 
	  weight: part_price.weight, 
	  price: part_price.price
	}
  }
  
  $scope.deletePartPrice = function(part_price){
  	if(confirm('Are you sure you want to delete ?')){
	  $http.delete('part_prices/' + part_price.id)
	  for(var i = 0; i < $scope.part_prices.length;i++){
	    if($scope.part_prices[i].id === part_price.id)
		  $scope.part_prices.splice(i,1);
	  }
      GenericService.showMessage('successMessage', 'Part successfully deleted.', 2000)
	}
  }
  
  $scope.createPartPrice = function(part_price){
  	part_price.make = $scope.make
  	part_price.currency = $scope.currency
	$http.post('part_prices', {part_price: part_price}).success(function(result){
	  if(result.status == 'SUCCESS'){
	  	$scope.createEnabled = !$scope.createEnabled;
	    part_price.id = result.part_price_id
	    $scope.backupPartPriceData(part_price)
	    $scope.part_price = null
	    $scope.part_prices[$scope.part_prices.length] = part_price;
	    GenericService.showMessage('successMessage', 'Part successfully created.', 2000)
	  }
	  else{
		GenericService.showMessage('errorMessages', result.messages, 2000)
	  }
	})
  }
  
  $scope.updatePartPrice = function(part_price){
	$http.put('part_prices/' + part_price.id, {part_price: part_price}).success(function(result){
	  if(result.status == 'SUCCESS'){
	    GenericService.showMessage('successMessage', 'Part successfully updated.', 2000)
	    $scope.backupPartPriceData(part_price)
	  }
	  else
		GenericService.showMessage('errorMessages', result.messages, 2000)
	})
  }
  
  $scope.cancelEdit = function(part_price){
    part_price.model = $scope.backupData[part_price.id].model
  	part_price.part_number = $scope.backupData[part_price.id].part_number
  	part_price.part_desc = $scope.backupData[part_price.id].part_desc
  	part_price.weight = $scope.backupData[part_price.id].weight
  	part_price.price = $scope.backupData[part_price.id].price
  }

  $scope.changeSortOrder = function(sort_field){
  	if($scope.sort == sort_field)
  		$scope.order = !$scope.order
  	else{
	  $scope.sort = sort_field
	  $scope.order = false
	}
  }

  $scope.getSortClass = function(sort_field){
  	if($scope.sort != sort_field)
      return 'sort_default'
  	else
  	  return 'sort_' + $scope.order
  }
  
}

//create generic functionality for proper error message display 