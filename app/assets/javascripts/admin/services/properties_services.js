(function ()
{
	"use strict"

	angular.module('propertiesServices', [])


	function PropertiesService($http)
	{
		return{
			all   : function ()
			{
				return $http.get("/admin/properties/")
			},
			show  : function (id)
			{
				return $http.get("/admin/properties/" + id)
			},
			create: function (obj)
			{
				return $http.post("/admin/properties/", obj)
			},
			edit: function (id)
			{
				return $http.get("/admin/properties/" + id + "/edit")
			},
			update: function (id, obj)
			{
				return $http.put("/admin/properties/" + id, obj)
			},
			delete: function (id)
			{
				return $http.delete("/admin/properties/" + id)
			}
		}
	}


	function ValuesService($http)
	{
		return{
			create: function (id, obj)
			{
				return $http.post("/admin/properties/" + id + "/values", obj)
			},
			delete: function (id, value_id)
			{
				return $http.delete("/admin/properties/" + id + "/values/" + value_id)
			}
		}
	}


	PropertiesService.$inject = ['$http'];
	ValuesService.$inject = ['$http'];
	angular
		.module('propertiesServices')
		.service('PropertiesService', PropertiesService)
		.service('ValuesService', ValuesService)


})()