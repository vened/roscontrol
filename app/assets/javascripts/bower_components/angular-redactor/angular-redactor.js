(function ()
{
	'use strict';

	/**
	 * usage: <textarea ng-model="content" redactor></textarea>
	 *
	 *    additional options:
	 *      redactor: hash (pass in a redactor options hash)
	 *
	 */
	angular.module('angular-redactor', [])
		.directive("redactor", [
			'$timeout',
			function ($timeout)
			{
				return {
					restrict: 'A',
					require : "ngModel",
					link    : function (scope, element, attrs, ngModel)
					{

						var csrf_token = angular.element('meta[name=csrf-token]').attr('content');
						var csrf_param = angular.element('meta[name=csrf-param]').attr('content');
						var params;
						if (csrf_param !== undefined && csrf_token !== undefined)
						{
							params = csrf_param + "=" + encodeURIComponent(csrf_token);
						}
						
						var updateModel = function updateModel(value)
							{
								scope.$apply(function ()
								{
									ngModel.$setViewValue(value);
								});
							},
							options = {
								changeCallback: updateModel,
								"imageUpload" : "/redactor_rails/pictures?" + params,
								"imageGetJson": "/redactor_rails/pictures",
								"fileUpload"  : "/redactor_rails/documents?" + params,
								"fileGetJson" : "/redactor_rails/documents",
								"path"        : "/assets/redactor-rails"
							},
							additionalOptions = attrs.redactor ?
								scope.$eval(attrs.redactor) : {},
							editor,
							$_element = angular.element(element);

						angular.extend(options, additionalOptions);

						// put in timeout to avoid $digest collision.  call render() to
						// set the initial value.
						$timeout(function ()
						{
							editor = $_element.redactor(options);
							ngModel.$render();
						});

						ngModel.$render = function ()
						{
							if (angular.isDefined(editor))
							{
								$timeout(function ()
								{
									$_element.redactor('set', ngModel.$viewValue || '');
								});
							}
						};
					}
				};
			}
		]);
})();

