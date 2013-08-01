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
  	alert(user.username)
	$http.put('users/' + user.id, {"user[id]": user.id, "user[username]": user.username, "user[role]":user.role}).success(function() {
	  alert('success !!!')
	});
  }
  $scope.deleteUser = function(id){
	/*$http.delete('users', {"user[username]": user.username, "user[role]":user.role}).success(function() {
	  alert('success !!!')
	});*/
  }
}




