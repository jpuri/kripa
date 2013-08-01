angular.module('user', ['ngGrid']).
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
  	//alert(user.username)
  }
  $scope.deleteUser = function(id){
  	//alert(user.username)
  }
}




