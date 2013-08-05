angular.module('user', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('', {templateUrl: 'partials/user_list.html',   controller: UserCtrl});
}]);

function UserCtrl($scope, $http) {
  $http.get('users/appUsers').success(function(data) {
    $scope.users = data;
  });
  $scope.saveUser = function(user){
  	$scope.clearErrorMessage()
	$http.put('users/' + user.id, {user: user}).success()
  }
  $scope.createUser = function(user){
  	$scope.clearErrorMessage()
	$http.post('users', {user: user}).success(function(result){
		if(result.status == 'SUCCESS'){
			user.id = result.user_id
	    	$scope.users[$scope.users.length] = user;
	    }
	    else{
	    	$scope.errorMessages = result.messages
	    }
	})
  }
  $scope.deleteUser = function(user){
  	$scope.clearErrorMessage()
  	if(confirm('Are you sure you want to delete ?')){
		$http.delete('users/' + user.id)
		for(var i = 0; i < $scope.users.length;i++){
			if($scope.users[i].id === user.id)
				$scope.users[i] = null
		}
	}
  }
  $scope.clearErrorMessage = function(){
    $scope.errorMessages = null
  }
}
