(function ()
{
	"use strict"

	var pages = angular.module("pages", []);

	pages.factory('Page', [
		'$http',
		function ($http)
		{
			return{
				find  : function (id)
				{
					return $http.get("/admin/pages/find/" + id);
				},
				create: function (obj)
				{
					return $http.post("/admin/pages", obj);
				},
				update: function (id, obj)
				{
					return $http.put("/admin/pages/" + id, obj);
				}
			}
		}
	]);

	pages.controller('PagesFormCtrl', function ($scope, $location, Page)
	{

		$scope.obj = {}

		$scope.submit = function ()
		{
			Page.create($scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/pages");
				}
			})
		}

		$scope.update = function (id)
		{
			Page.update(id, $scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/pages");
				}
			})
		}

		$scope.findPage = function (id)
		{
			Page.find(id).success(function (val)
			{
				$scope.obj = val
			})
		}

		$scope.setCatalog = function (category)
		{
			var json = JSON.parse(category)
			$scope.obj.name = json.name
			$scope.obj.path = "catalog" + json.path
		}


		var editor = CKEDITOR.replace('body',
			{
				"height"                : "600px",
				"stylesSet"             : [],
				"extraPlugins"          : "stylesheetparser,richfile,MediaEmbed,showblocks",
				"removePlugins"         : "scayt,menubutton,image,forms",
				"contentsCss"           : "/assets/admin/rich/editor.css",
				"removeDialogTabs"      : "link:advanced;link:target",
				"startupOutlineBlocks"  : true,
				"forcePasteAsPlainText" : true,
				"format_tags"           : "h2;h3;h4;p;pre",
				"toolbar"               : [
					[
						"Format",
						"Styles"
					],
					[
						"Bold",
						"Italic",
						"-",
						"NumberedList",
						"BulletedList",
						"Blockquote",
						"-",
						"richImage",
						"-",
						"Link",
						"Unlink",
						'HorizontalRule'
					],
					[
						"Source",
						"ShowBlocks",
						"Maximize"
					]
				],
				"language"              : "ru",
				"richBrowserUrl"        : "/rich/files/",
				"uiColor"               : "#f4f4f4",
				"allowed_styles"        : [
					"thumb",
					"large"
				],
				"default_style"         : "large",
				"insert_many"           : false,
				"allow_document_uploads": false,
				"allow_embeds"          : false,
				"placeholder_image"     : "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==",
				"preview_size"          : "100px",
				"hidden_input"          : true,
				"paginates_per"         : 34,
				"width"                 : "100%"}
		);


		editor.on('pasteState', function ()
		{
			$scope.$apply(function ()
			{
				$scope.obj.body = editor.getData();
			});

		});

	});

}())


