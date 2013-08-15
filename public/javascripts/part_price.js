function PartPriceCtrl($scope, $http, $timeout, $routeParams) {
  $scope.make = $routeParams.make
  $scope.currency = $routeParams.currency
  $scope.model = ""
  $scope.part_number = ""
  $scope.resetSortParams = function(){
    $scope.sort = "part_number"
    $scope.order = false
  }
  $scope.searchPartPrices = function(){
	  $http.get('part_prices?make=' + $scope.make + "&currency=" + $scope.currency + "&model=" + $scope.model + 
	  "&part_number=" + $scope.part_number).success(function(data) {
	    $scope.part_prices = data;
	    angular.forEach($scope.part_prices, function(part_price){
	      part_price.hidden_model = part_price.model
	      part_price.hidden_part_number = part_price.part_number
	      part_price.hidden_part_desc = part_price.part_desc
	      part_price.hidden_weight = part_price.weight
	      part_price.hidden_price = part_price.price
	    });
	  	$scope.resetSortParams();
	  });
  }
  $scope.searchPartPrices()
  $scope.deletePartPrice = function(part_price){
  	if(confirm('Are you sure you want to delete ?')){
	  $http.delete('part_prices/' + part_price.id)
	  for(var i = 0; i < $scope.part_prices.length;i++){
	    if($scope.part_prices[i].id === part_price.id)
		  $scope.part_prices[i] = null
	    //$scope.showMessage('successMessage', 'Part successfully deleted.', 2000)
	  }
	}
  }
  $scope.searchPartPrices()
  $scope.resetSearchParams = function(){
	  $scope.model = ""
	  $scope.part_number = ""
  }
  $scope.createPartPrice = function(part_price){
  	part_price.make = $scope.make
  	part_price.currency = $scope.currency
	$http.post('part_prices', {part_price: part_price}).success(function(result){
	  if(result.status == 'SUCCESS'){
	  	$scope.createEnabled = !$scope.createEnabled;
	    part_price.id = result.part_price_id
	    $scope.part_prices[$scope.part_prices.length] = part_price;
	    //$scope.showMessage('successMessage', 'Part successfully created.', 2000)
	  }
	  else{
		//$scope.showMessage('errorMessages', result.messages, 2000)
	  }
	})
  }
  $scope.updatePartPrice = function(part_price){
	$http.put('part_prices/' + part_price.id, {part_price: part_price}).success(function(result){
	  //if(result.status == 'SUCCESS')
	    //$scope.showMessage('successMessage', 'Part successfully updated.', 2000)
	  //else
		//$scope.showMessage('errorMessages', result.messages, 2000)
	})
  }
  $scope.cancelEdit = function(part_price){
      part_price.model = part_price.hidden_model
      part_price.part_number = part_price.hidden_part_number
      part_price.part_desc = part_price.hidden_part_desc
      part_price.weight = part_price.hidden_weight
      part_price.price = part_price.hidden_price
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

//message display //for success or failure
//cancel edit to be implemented
