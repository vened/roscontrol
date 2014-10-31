//= require ./routes
//= require_directory ./categories
//= require_directory ./brands
//= require ./pages/pages

// services
//= require ./helpers
//= require_directory ./services

// component properties
//= require_directory ./components/properties
//= require_directory ./components/products
//= require_directory ./components/alert
//= require_directory ./components/galleries
//= require_directory ./components/news

// directives
//= require ./uploader/uploader.directives


(function ()
{
	"use strict"

	angular.module("admin", [
		"ngResource",
		"ngRoute",

		// routes
		"constants",
		"HelpersServices",
		"routes",

		// controllers
		"alertControllers",
		"propertiesControllers",
		"productsControllers",
		"galleriesControllers",
		"newsControllers",
		"categories",
		"brands",
		"pages",

		// directives
		"uploader.directives",

		// services
		"uploader.services",
		"propertiesServices",
		"productsServices",
		"galleriesServices",
		"pagesServices"

	])


}());
