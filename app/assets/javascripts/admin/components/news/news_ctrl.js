(function ()
{
	"use strict"

	angular.module("newsControllers", []);


	function NewsFormCtrl($scope)
	{
		var editor = CKEDITOR.replace('news_body',
			{
				"height"                : "400px",
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

	}

	NewsFormCtrl.$inject = [
		'$scope'
	];
	angular
		.module('newsControllers')
		.controller('NewsFormCtrl', NewsFormCtrl);


}());
