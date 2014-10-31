(function ()
{
	"use strict"

	angular.module("alertControllers", []);

	AlertCtrl.$inject = [
		'$rootScope',
		'$scope',
		'$timeout'
	];
	angular
		.module('alertControllers')
		.controller('AlertCtrl', AlertCtrl);


	function AlertCtrl($rootScope, $scope, $timeout)
	{
		$rootScope.$on('alert', function (event, data)
		{
			$scope.success = data;
			$timeout(function ()
			{
				$scope.success = false;
			}, 1500);
		})

		$scope.alertClose = function ()
		{
			$scope.success = false;
		}

	}


}());
