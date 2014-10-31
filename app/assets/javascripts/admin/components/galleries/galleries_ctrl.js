(function ()
{
	"use strict"

	angular.module('galleriesControllers', []);


	function GalleriesIndexCtrl($rootScope, $scope, $location, GalleryService, allGalleries)
	{
		$rootScope.menuActive = 'galleries';
		$scope.objs = allGalleries.data;

		$scope.itemDelete = function(id){
			GalleryService.delete(id).success(function(data){
				$rootScope.$broadcast('alert', "Галлерея " + data.name + " успешно удалена!")
				$location.path('/galleries/').replace();
			})
		}
		
		$scope.$on('$destroy', function ()
		{
			$rootScope.menuActive = false;
		});
	}

	function GalleriesNewCtrl($rootScope, $scope, $location, GalleryService, newGallery, pagesAll)
	{
		$rootScope.menuActive = 'galleries';
		$scope.obj = newGallery.data;
		$scope.pages = pagesAll.data;

		$scope.submit = function ()
		{
			GalleryService.update($scope.obj).success(function (data)
			{
				$rootScope.$broadcast('alert', "Галлерея " + data.name + " успешно сохранена!")
				$location.path('/galleries/').replace();
			})
		}
		$scope.$on('$destroy', function ()
		{
			$rootScope.menuActive = false;
		});
	}

	function GalleriesEditCtrl($rootScope, $scope, $location, GalleryService, editGallery, pagesAll)
	{
		$rootScope.menuActive = 'galleries';
		$scope.obj = editGallery.data;
		$scope.pages = pagesAll.data;

		$scope.submit = function ()
		{
			GalleryService.update($scope.obj).success(function (data)
			{
				$rootScope.$broadcast('alert', "Галлерея " + data.name + " успешно обновлена!")
				$location.path('/galleries/').replace();
			})
		}
		$scope.$on('$destroy', function ()
		{
			$rootScope.menuActive = false;
		});
	}

	GalleriesIndexCtrl.$inject = [
		'$rootScope',
		'$scope',
		'$location',
		'GalleryService',
		'allGalleries'
	];
	GalleriesNewCtrl.$inject = [
		'$rootScope',
		'$scope',
		'$location',
		'GalleryService',
		'newGallery',
	    'pagesAll'
	];
	GalleriesEditCtrl.$inject = [
		'$rootScope',
		'$scope',
		'$location',
		'GalleryService',
		'editGallery',
	    'pagesAll'
	];
	angular
		.module('galleriesControllers')
		.controller('GalleriesIndexCtrl', GalleriesIndexCtrl)
		.controller('GalleriesNewCtrl', GalleriesNewCtrl)
		.controller('GalleriesEditCtrl', GalleriesEditCtrl);


}());