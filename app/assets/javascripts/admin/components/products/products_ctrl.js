(function ()
{
	"use strict"

	angular.module("productsControllers", []);


	function ProductsFormCtrl($rootScope, $scope, ProductsService)
	{
		$scope.obj = {}
		$scope.obj.product = {}
		$scope.obj.product.product_categories = {}

		$scope.submit = function ()
		{
			ProductsService.create($scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/products");
				}
			})
		}

		$scope.update = function (id)
		{
			ProductsService.update(id, $scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/products");
				}
			})
		}

		$scope.findProduct = function (id)
		{
			ProductsService.find(id).success(function (res)
			{
				$scope.obj.product = res.product
				$scope.obj.sub_products = res.sub_products
				$scope.categories = res.categories
				$scope.brands = res.brands
				$scope.properties = res.properties
				$scope.product_properties = res.product_properties
			})
		}

		$scope.setProperty = function (property_id, product_id)
		{
			console.log(property_id, product_id)
			var obj = {"product": {"id": product_id, "property_id": property_id}}
			ProductsService.setProperty(property_id, product_id, obj).success(function (data)
			{
				$scope.properties = data.properties
				$scope.product_properties = data.product_properties
			})
		}

		$scope.setPropertyValue = function (product_id, property_id, value_id)
		{
			var obj = {"product": {"id": product_id, "property_id": property_id, "value_id": value_id}}
			ProductsService.setPropertyValue(product_id, property_id, value_id, obj).success(function (data)
			{
				$scope.properties = data.properties
				$scope.product_properties = data.product_properties
			})
		}

		$scope.setBrand = function (product_id, brand_id)
		{
			var obj = {"product": {"id": product_id, "brand_id": brand_id}}
			ProductsService.setBrand(product_id, brand_id, obj).success(function (data)
			{
				$scope.brands = data.brands
			})
		}

		$scope.setCategory = function (product_id, category_id)
		{
			var obj = {"product": {"id": product_id, "category_id": category_id}}
			ProductsService.setCategory(product_id, category_id, obj).success(function (data)
			{
				$scope.category = data.category
			})
		}


		/**
		 * BEGIN SubProducts
		 */
		$scope.setSubProduct = function (product_id)
		{
			ProductsService.setSubProduct(product_id).success(function (data)
			{
				$scope.obj.sub_products = data
			})
		}

		$scope.updateSubProduct = function (sub_product)
		{
			ProductsService.updateSubProduct(sub_product.id, sub_product).success(function (data)
			{
				$scope.obj.sub_products = data
			})
		}

		$scope.destroySubProduct = function (sub_product)
		{
			ProductsService.destroySubProduct(sub_product.product_id, sub_product.id).success(function (data)
			{
				$scope.obj.sub_products = data
			})
		}
		/**
		 * END SubProducts
		 */

	}

	ProductsFormCtrl.$inject = [
		'$rootScope',
		'$scope',
		'ProductsService'
	];
	angular
		.module('productsControllers')
		.controller('ProductsFormCtrl', ProductsFormCtrl);


}());
