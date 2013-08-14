angular.module('kripa', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: 'partials/users-index.html',   controller: UserCtrl})
}]);