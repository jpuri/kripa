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
  $http.get('sessions/0').success(function(result) {
	  if(result.status == 'SUCCESS'){
	  	$scope.setCurrentUser(result)
	  }
	  else{
	  	$scope.showLogin = true
	  }
  });
  $scope.createSession = function(username, password){
	$http.post('sessions', {username: username, password: password}).success(function(result){
	  if(result.status == 'SUCCESS'){
	  	$scope.setCurrentUser(result)
	  }
	  else{
	  }
	})
  }
  $scope.deleteSession = function(){
	$http.delete('sessions/0').success(function(result){
	  if(result.status == 'SUCCESS'){
	  	$scope.removeCurrentUser()
	  }
	  else{
	  }
	})
  }
  $scope.setCurrentUser = function(result){
  	$rootScope.user_name = result.username
  	$rootScope.user_role = result.role
  	if(result.role == 'admin')
  	  $rootScope.user_isadmin = true
  }
  $scope.removeCurrentUser = function(){
  	$rootScope.user_name = null
  	$rootScope.user_role = null
    $rootScope.user_isadmin = null
  }
}

//REFACTORED

//deleting useless vendor js files 
//error messages in failure cases to be handled