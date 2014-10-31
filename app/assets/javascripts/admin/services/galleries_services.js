(function ()
{
	"use strict"

	angular.module('galleriesServices', [])


	function GalleryService($http)
	{
		return{
			all   : function ()
			{
				return $http.get("/admin/galleries/")
			},
			new: function ()
			{
				return $http.get("/admin/galleries/new/")
			},
			edit: function (id)
			{
				return $http.get("/admin/galleries/" + id + "/edit")
			},
			update: function (obj)
			{
				return $http.put("/admin/galleries/" + obj.id, obj)
			},
			delete: function (id)
			{
				return $http.delete("/admin/galleries/" + id)
			}
		}
	}


	GalleryService.$inject = ['$http'];
	angular
		.module('galleriesServices')
		.service('GalleryService', GalleryService);


})()