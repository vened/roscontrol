(function ()
{
	"use strict"

	angular.module('uploader.services', [])


	function UploadedPhotosService($http)
	{

		this.find = function (resource_name, resource_id)
		{
			return $http.get("/admin/"+ resource_name +"/photos/" + resource_id);
		}

		this.edit = function (obj)
		{
			return $http.put("/admin/photos/edit/" + obj.id, obj);
		}
		
		this.destroy = function (id)
		{
			return $http.delete("/admin/photos/" + id);
		}
		
	}


	UploadedPhotosService.$inject = ['$http'];
	angular
		.module('uploader.services')
		.service('UploadedPhotosService', UploadedPhotosService)


})()