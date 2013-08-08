angular.module('user', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('', {templateUrl: 'partials/user_list.html',   controller: UserCtrl});
}]);

UserCtrl = function($scope, $http, $timeout) {
  $http.get('users/appUsers').success(function(data) {
    $scope.users = data;
  });
  $scope.saveUser = function(user){
	$http.put('users/' + user.id, {user: user}).success(function(result){
	  if(result.status == 'SUCCESS')
	    $scope.showMessage('successMessage', 'User successfully updated.', 2000)
	  else
		$scope.showMessage('errorMessages', result.messages, 2000)
	})
  }
  $scope.createUser = function(user){
	$http.post('users', {user: user}).success(function(result){
	  if(result.status == 'SUCCESS'){
	    user.id = result.user_id
	    $scope.users[$scope.users.length] = user;
	    $scope.showMessage('successMessage', 'User successfully created.', 2000)
	  }
	  else{
		$scope.showMessage('errorMessages', result.messages, 2000)
	  }
	})
  }
  $scope.deleteUser = function(user){
  	if(confirm('Are you sure you want to delete ?')){
	  $http.delete('users/' + user.id)
	  for(var i = 0; i < $scope.users.length;i++){
	    if($scope.users[i].id === user.id)
		  $scope.users[i] = null
	    $scope.showMessage('successMessage', 'User successfully deleted.', 2000)
	  }
	}
  }
  $scope.showMessage = function(messageElement, message, time){
  	$scope[messageElement] = message
  	$timeout(function(){
  	  $scope[messageElement] = null
  	}, time)
  }
  $scope.showChangePassword = function(user){
  	$scope.changePasswordUser = user
    $scope.changePassword = true
  }
  $scope.updatePassword = function(){
	$http.put('users/' + $scope.changePasswordUser.id, {user: $scope.changePasswordUser, changePassword: true}).success(function(result){
	  if(result.status == 'SUCCESS'){
	    $scope.showMessage('successMessage', 'Password successfully updated for ' + $scope.changePasswordUser.username, 2000)
  		$scope.changePasswordUser.password = undefined
  		$scope.changePasswordUser.password_confirmation = undefined
  		$scope.changePasswordUser = undefined
		$scope.changePassword = !$scope.changePassword
	  }
	  else{
	    $scope.showMessage('passwordErrorMessage', result.messages, 2000)
	  }
	})
  }
}

//for error/success messages there should be timeout