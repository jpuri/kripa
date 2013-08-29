var kripa = angular.module('kripa', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: 'partials/users-index.html',   controller: UserCtrl}).
      when('/part_prices', {templateUrl: 'partials/part_price-index.html',   controller: PartPriceCtrl})
}]);

kripa.factory('GenericService', function($rootScope, $timeout) {
  return {
    showMessage : function(messageElement, message, time){
	  $rootScope[messageElement] = message
	  $timeout(function(){
	    $rootScope[messageElement] = null
	  }, time)
    }
  };
});

function SessionCtrl($rootScope, $scope, $http, GenericService) {
	$scope.today = new Date();
  $scope.createSession = function(username, password){
	$http.post('sessions', {username: username, password: password}).success(function(result){
	  if(result.status == 'SUCCESS'){
	  	$rootScope.user_name = result.username
	  	$rootScope.user_role = result.role
	  }
	  else{
	  }
	})
  }
  $scope.deleteSession = function(){
	$http.delete('sessions/0').success(function(result){
	  if(result.status == 'SUCCESS'){
	  	$rootScope.user_name = null
	  	$rootScope.user_role = null
	  }
	  else{
	  }
	})
  }
}

//REFACTORED

//deleting useless vendor js files 