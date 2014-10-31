(function ()
{
	"use strict"

	var brands = angular.module("brands", []);

	brands.factory('Brand', [
		'$http',
		function ($http)
		{
			return{
				find  : function (id, locale)
				{
					return $http.get("/admin/brands/find/" + id);
				},
				create: function (obj)
				{
					return $http.post("/admin/brands", obj);
				},
				update: function (id, obj)
				{
					return $http.put("/admin/brands/" + id, obj);
				}
			}
		}
	]);

	brands.controller('BrandsFormCtrl', function ($scope, $location, Brand, TransliterateService)
	{
		$scope.obj = {};
		$scope.obj.brand = {};

		$scope.submit = function ()
		{
			Brand.create($scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/brands");
				}
			})
		}

		$scope.update = function (id)
		{
			Brand.update(id, $scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/brands");
				}
			})
		}


		$scope.findBrand = function (id)
		{
			Brand.find(id).success(function (val)
			{
				$scope.obj = val
			})
		}

		$scope.setPath = function(data){
			$scope.obj.path = TransliterateService(data)
		}

	});

}())


