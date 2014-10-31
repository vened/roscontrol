(function ()
{
	"use strict"

	angular.module("feedback", [])

		.factory('Feedback', [
			'$http',
			function ($http)
			{
				return{
					create: function (obj)
					{
						return $http.post("/feedback/create", obj);
					}
				}
			}
		])

		.controller('FeedbackFormCtrl', function ($scope, Feedback)
		{

			$scope.submit = function ()
			{
				Feedback.create($scope.obj).success(function (data)
				{
					if (data.errors)
					{
						$scope.alerts = [];
						angular.forEach(data.errors, function (value, key)
						{
							$scope.addAlert({ type: 'danger', msg: key + ' ' + value })
						});
					}
					else
					{
						$scope.alerts = [];
						$scope.addAlert({ type: 'success', msg: data.name + ' , ваше сообщение успешно отправлено! Спасибо!' })
						$scope.obj = {};
					}
				})
			}

			$scope.alerts = [];
			$scope.addAlert = function (obj)
			{
				$scope.alerts.push(obj);
			};

			$scope.closeAlert = function (index)
			{
				$scope.alerts.splice(index, 1);
			};

		});

}())


