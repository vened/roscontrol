(function ()
{
	"use strict"

	angular.module('carouselControllers', []);

	function CarouselService($http)
	{
		return{
			find: function ()
			{
				return $http.get("/pages/carousel/")
			}
		}
	}


	function CarouselCtrl($scope, CarouselService)
	{
		$scope.CarouselFind = function(){
			CarouselService.find().success(function(data){
				$scope.slides = data;
			})
		}
	}

	CarouselCtrl.$inject = [
		'$scope',
		'CarouselService'
	];
	CarouselService.$inject = ['$http'];
	angular
		.module('carouselControllers')
		.controller('CarouselCtrl', CarouselCtrl)
		.service('CarouselService', CarouselService);


}());