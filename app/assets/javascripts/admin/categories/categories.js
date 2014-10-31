(function ()
{
	"use strict"

	var categories = angular.module("categories", []);

	categories.factory('Category', [
		'$http',
		function ($http)
		{
			return{
				find  : function (id, locale)
				{
					return $http.get("/admin/categories/find/" + id);
				},
				create: function (obj)
				{
					return $http.post("/admin/categories", obj);
				},
				update: function (id, obj)
				{
					return $http.put("/admin/categories/" + id, obj);
				}
			}
		}
	]);

	categories.controller('CategoriesFormCtrl', function ($scope, $location, Category)
	{
		$scope.obj = {};
		$scope.obj.category = {};


		$scope.submit = function ()
		{
			Category.create($scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/categories");
				}
			})
		}

		$scope.update = function (id)
		{
			Category.update(id, $scope.obj).success(function (val)
			{
				if (val.error)
				{
					$scope.errors = val.error
				}
				if (val.success)
				{
					window.location.replace("/admin/categories");
				}
			})
		}


		$scope.findCategory = function (id)
		{
			Category.find(id).success(function (val)
			{
				$scope.obj = val
			})
		}


        var editor = CKEDITOR.replace('body',
            {
                "height": "300px",
                "stylesSet": [],
                "extraPlugins": "stylesheetparser,richfile,MediaEmbed,showblocks",
                "removePlugins": "scayt,menubutton,image,forms",
                "contentsCss": "/assets/admin/rich/editor.css",
                "removeDialogTabs": "link:advanced;link:target",
                "startupOutlineBlocks": true,
                "forcePasteAsPlainText": true,
                "format_tags": "h2;h3;h4;p;pre",
                "toolbar": [
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
                "language": "ru",
                "richBrowserUrl": "/rich/files/",
                "uiColor": "#f4f4f4",
                "allowed_styles": [
                    "thumb",
                    "large"
                ],
                "default_style": "large",
                "insert_many": false,
                "allow_document_uploads": false,
                "allow_embeds": false,
                "placeholder_image": "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==",
                "preview_size": "100px",
                "hidden_input": true,
                "paginates_per": 34,
                "width": "100%"}
        );


        editor.on('pasteState', function () {
            $scope.$apply(function () {
                $scope.obj.body = editor.getData();
            });

        });

	});

}())


