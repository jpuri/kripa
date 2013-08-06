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
  	$scope.clearMessages()
	$http.put('users/' + user.id, {user: user}).success(function(result){
		if(result.status == 'SUCCESS'){
			$scope.successMessage = 'User successfully updated.'
	    }
	    else{
	    	$scope.errorMessages = result.messages
	    }
	})
  }
  $scope.createUser = function(user){
  	$scope.clearMessages()
	$http.post('users', {user: user}).success(function(result){
		if(result.status == 'SUCCESS'){
			user.id = result.user_id
	    	$scope.users[$scope.users.length] = user;
			$scope.successMessage = 'User successfully created.'
	    }
	    else{
	    	$scope.errorMessages = result.messages
	    }
	})
  }
  $scope.deleteUser = function(user){
  	$scope.clearMessages()
  	if(confirm('Are you sure you want to delete ?')){
		$http.delete('users/' + user.id)
		for(var i = 0; i < $scope.users.length;i++){
			if($scope.users[i].id === user.id)
				$scope.users[i] = null
			$scope.successMessage = 'User successfully deleted.'
		}
	}
  }
  $scope.clearMessages = function(){
    $scope.successMessage = null
    $scope.errorMessages = null
  }
  $scope.showChangePassword = function(user){
  	$scope.changePasswordUser = user
    $scope.changePassword = true
  }
  $scope.updatePassword = function(){
  	$scope.clearMessages()
	$http.put('users/' + $scope.changePasswordUser.id, {user: $scope.changePasswordUser, changePassword: true}).success(function(result){
		if(result.status == 'SUCCESS'){
			$scope.successMessage = 'Password successfully updated for ' + $scope.changePasswordUser.username
  			$scope.changePasswordUser.password = undefined
  			$scope.changePasswordUser.password_confirmation = undefined
  			$scope.changePasswordUser = undefined
		    $scope.changePassword = !$scope.changePassword
	    }
	    else{
	    	$scope.passwordErrorMessage = result.messages
	    }
	})
  }
}
