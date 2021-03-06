(function ()
{
	"use strict"

	angular.module('uploader.directives', ["angularFileUpload"])


	function uploaderComponent(FileUploader, UPLOADER_COMPONENT)
	{
		return{
			restrict   : 'E',
			templateUrl: UPLOADER_COMPONENT,
			scope      : {
				uploadUrl   : '@uploadUrl',
				resourceName: '@resourceName',
				resourceId  : '@resourceId'
			},
			controller : function ($rootScope, $scope)
			{

				$scope.ResourceId = [];
				$scope.ResourceId[0] = {};
				$scope.ResourceId[0][$scope.resourceName] = $scope.resourceId;

				var uploader = $scope.uploader = new FileUploader({
					url       : $scope.uploadUrl,
					alias     : 'photo',
					formData  : $scope.ResourceId,
					autoUpload: true
				});

				// FILTERS
				uploader.filters.push({
					name: 'imageFilter',
					fn  : function (item)
					{
						var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
						return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
					}
				});


				uploader.onCompleteItem = function (item, response)
				{
					item.remove()
				};

				uploader.onCompleteAll = function ()
				{
					$rootScope.$emit('onCompleteUpload');
					//					$scope.findPhoto($scope.CategoryId[0].category_id)
				};

				//				$scope.photoDestroy = function (id)
				//				{
				//					CategoryPhoto.destroy(id).success(function (val)
				//					{
				//						$scope.findPhoto($scope.CategoryId[0].category_id)
				//					})
				//				}


			}
		}
	}


	function uploaderThumb($window)
	{
		var helper = {
			support: !!($window.FileReader && $window.CanvasRenderingContext2D),
			isFile : function (item)
			{
				return angular.isObject(item) && item instanceof $window.File;
			},
			isImage: function (file)
			{
				var type = '|' + file.type.slice(file.type.lastIndexOf('/') + 1) + '|';
				return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
			}
		};
		return {
			restrict: 'A',
			template: '<canvas/>',
			link    : function (scope, element, attributes)
			{
				if (!helper.support)
				{
					return;
				}
				var params = scope.$eval(attributes.uploaderThumb);
				if (!helper.isFile(params.file))
				{
					return;
				}
				if (!helper.isImage(params.file))
				{
					return;
				}
				var canvas = element.find('canvas');
				var reader = new FileReader();
				reader.onload = onLoadFile;
				reader.readAsDataURL(params.file);
				function onLoadFile(event)
				{
					var img = new Image();
					img.onload = onLoadImage;
					img.src = event.target.result;
				}

				function onLoadImage()
				{
					var width = params.width || this.width / this.height * params.height;
					var height = params.height || this.height / this.width * params.width;
					canvas.attr({ width: width, height: height });
					canvas[0].getContext('2d').drawImage(this, 0, 0, width, height);
				}
			}
		}
	}


	function photosUploaded(UploadedPhotosService, UPLOADER_PHOTOS)
	{
		return{
			restrict   : 'E',
			templateUrl: UPLOADER_PHOTOS,
			scope      : {
				resourceName: '@resourceName',
				resourceId  : '@resourceId',
				showForm    : '@'
			},
			controller : function ($rootScope, $scope)
			{
				
				$scope.findPhoto = function ()
				{
					UploadedPhotosService.find($scope.resourceName, $scope.resourceId).success(function (val)
					{
						$scope.photos = val;
					})
				}
				$scope.findPhoto();


				$scope.photoDestroy = function (id)
				{
					UploadedPhotosService.destroy(id).success(function (val)
					{
						$scope.findPhoto();
					})
				}


				$scope.saveDataPhoto = true;
				$scope.submit = function (photo)
				{
					$scope.saveDataPhoto = false;
					photo.photo = null;
					UploadedPhotosService.edit(photo).success(function (data)
					{
						$scope.saveDataPhoto = true;
					})
				}


				$rootScope.$on('onCompleteUpload', function ($e)
				{
					$scope.findPhoto();
				});

			}
		}
	}


	uploaderThumb.$inject = ['$window'];
	uploaderComponent.$inject = ['FileUploader', 'UPLOADER_COMPONENT'];
	photosUploaded.$inject = ['UploadedPhotosService', 'UPLOADER_PHOTOS'];
	angular
		.module('uploader.directives')
		.directive('uploaderThumb', uploaderThumb)
		.directive('uploaderComponent', uploaderComponent)
		.directive('photosUploaded', photosUploaded);


})()