(function ()
{
	"use strict"

	var filters = angular.module("filters", []);

	filters.factory('ProductFilter', [
		'$http',
		function ($http)
		{
			return{
				setFilters: function (obj)
				{
//					return $http.get("/product/filters/")
					return $http({
						url   : "/product/filters/",
						method: "GET",
						params: obj
					});
				}
			}
		}
	]);

	filters.controller('ProductFilterCtrl', function ($scope, ProductFilter)
	{

//		ProductFilter.allFilters().success(function(res){
//			$scope.filters = res;
//		})

		

		$scope.prod = {name: "wewqe"}
		$scope.setFilters = function ()
		{
		console.log($scope.obj)
			ProductFilter.setFilters($scope.obj).success(function(res){
				$scope.products = res;
			})
		}
	});

}())


