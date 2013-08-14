angular.module('kripa', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: 'partials/users-index.html',   controller: UserCtrl}).
      when('/part_prices', {templateUrl: 'partials/part_price-index.html',   controller: PartPriceCtrl})
}]);