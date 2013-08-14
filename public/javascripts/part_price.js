function PartPriceCtrl($scope, $http, $timeout, $routeParams) {
  $scope.make = $routeParams.make
  $scope.currency = $routeParams.currency
  $http.get('part_prices?make=' + $scope.make + "&currency=" + $scope.currency).success(function(data) {
    $scope.part_prices = data;
  });
}
