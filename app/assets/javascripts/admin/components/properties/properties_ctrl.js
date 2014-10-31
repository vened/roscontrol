(function ()
{
	"use strict"

	angular.module("propertiesControllers", []);


	function PropertiesIndexCtrl($rootScope, $scope, PropertiesService, allProperties)
	{
		$rootScope.menuActive = 'property';
		$scope.properties = allProperties.data

		$scope.itemDelete = function (id)
		{
			PropertiesService.delete(id).success(function (data)
			{
				var dataAlert = "Свойство " + data.name + "успешно удалено!"
				$rootScope.$broadcast('alert', dataAlert)
			})
			PropertiesService.all().success(function (data)
			{
				$scope.properties = data
			})
		}
	}


	function PropertiesShowCtrl($rootScope, $scope, $routeParams, Property, ValuesService)
	{
		$rootScope.menuActive = 'property';
		$scope.obj = Property.data
		$scope.submit = function ()
		{
			ValuesService.create($routeParams.id, $scope.values).success(function (data)
			{
				$scope.obj = data;
				$scope.values = {}
			})
		}

		$scope.removeValue = function (id)
		{
			ValuesService.delete($routeParams.id, id).success(function (data)
			{
				$scope.obj = data;
			})
		}

	}


	function PropertiesNewCtrl($rootScope, $scope, $location, PropertiesService)
	{
		$rootScope.menuActive = 'property';
		$scope.submit = function ()
		{
			PropertiesService.create($scope.obj).success(function (data)
			{
				var dataAlert = "Свойство " + data.name + " успешно сохранено!"
				$rootScope.$broadcast('alert', dataAlert)
				$location.path('/properties/' + data.id).replace();
			})
		}
	}


	function PropertiesEditCtrl($rootScope, $scope, $location, $routeParams, PropertiesService, Property)
	{
		$rootScope.menuActive = 'property';
		$scope.obj = Property.data

		$scope.submit = function ()
		{
			PropertiesService.update($routeParams.id, $scope.obj).success(function (data)
			{
				var dataAlert = "Свойство " + data.name + " успешно сохранено!"
				$rootScope.$broadcast('alert', dataAlert)
				$location.path('/properties').replace();
			})
		}
	}

	PropertiesIndexCtrl.$inject = [
		'$rootScope',
		'$scope',
		'PropertiesService',
		'allProperties'
	];
	PropertiesShowCtrl.$inject = [
		'$rootScope',
		'$scope',
		'$routeParams',
		'Property',
		'ValuesService'
	];
	PropertiesNewCtrl.$inject = [
		'$rootScope',
		'$scope',
		'$location',
		'PropertiesService'
	];
	PropertiesEditCtrl.$inject = [
		'$rootScope',
		'$scope',
		'$location',
		'$routeParams',
		'PropertiesService',
		'Property'
	];
	angular
		.module('propertiesControllers')
		.controller('PropertiesShowCtrl', PropertiesShowCtrl)
		.controller('PropertiesIndexCtrl', PropertiesIndexCtrl)
		.controller('PropertiesNewCtrl', PropertiesNewCtrl)
		.controller('PropertiesEditCtrl', PropertiesEditCtrl);


}());
