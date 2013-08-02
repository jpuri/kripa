angular.module('user', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('', {templateUrl: 'partials/user_list.html',   controller: UserListCtrl});
}]);

function UserListCtrl($scope, $http) {
  $scope.editorEnabled = false;
  $http.get('users/appUsers').success(function(data) {
    $scope.users = data;
  });
  $scope.saveUser = function(user){
	$http.put('users/' + user.id, {user: user}).success()
  }
  $scope.createUser = function(user){
	$http.post('users', {user: user}).success(function(result){
		user.id = result.user_id
    	$scope.users[$scope.users.length] = user;
	})
  }
  $scope.deleteUser = function(user){
	$http.delete('users/' + user.id)
	for(var i = 0; i < $scope.users.length;i++){
		if($scope.users[i].id === user.id)
			$scope.users[i] = null
	}
  }
}
