(function ()
{
	"use strict"

	angular.module('productsServices', [])


	function ProductsService($http)
	{
		return{
			find            : function (id)
			{
				return $http.get("/admin/products/find/" + id);
			},
			create          : function (obj)
			{
				return $http.post("/admin/products", obj);
			},
			update          : function (id, obj)
			{
				return $http.put("/admin/products/" + id, obj);
			},
			setPropertyValue: function (product_id, property_id, value_id, obj)
			{
				return $http.post("/admin/products/" + product_id + "/property/" + property_id + "/value/" + value_id, obj);
			},
			setBrand        : function (product_id, brand_id, obj)
			{
				return $http.post("/admin/products/" + product_id + "/brand/" + brand_id, obj);
			},
			setCategory     : function (product_id, category_id, obj)
			{
				return $http.post("/admin/products/" + product_id + "/category/" + category_id, obj);
			},
			setSubProduct   : function (product_id)
			{
				return $http.get("/admin/products/" + product_id + "/sub_product/new");
			},
			updateSubProduct   : function (sub_product_id, obj)
			{
				return $http.put("/admin/sub_product/" + sub_product_id, obj);
			},
			destroySubProduct   : function (product_id, sub_product_id)
			{
				return $http.get("/admin/products/" + product_id + "/sub_product/" + sub_product_id + "/destroy");
			}
		}
	}

	ProductsService.$inject = ['$http'];
	angular
		.module('productsServices')
		.service('ProductsService', ProductsService);


})()