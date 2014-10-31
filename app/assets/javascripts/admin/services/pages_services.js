(function ()
{
	"use strict"

	angular.module('pagesServices', [])


	function PageService($http)
	{
		return{
			all   : function ()
			{
				return $http.get("/admin/pages/all")
			}
		}
	}


	PageService.$inject = ['$http'];
	angular
		.module('pagesServices')
		.service('PageService', PageService);


})()