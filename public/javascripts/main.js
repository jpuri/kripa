var kripa = angular.module('kripa', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: 'partials/users-index.html',   controller: UserCtrl}).
      when('/part_prices', {templateUrl: 'partials/part_price-index.html',   controller: PartPriceCtrl})
}]);

kripa.factory('UtilService', function($rootScope, $timeout) {
  return {
      showMessage : function(messageElement, message, time){
		  $rootScope[messageElement] = message
		  $timeout(function(){
		  $rootScope[messageElement] = null
		}, time)
	  }
  };
});

//deleting useless vendor js files 