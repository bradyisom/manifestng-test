angular.module('manifestngApp')
	.controller 'LoginCtrl', ['$scope', '$routeParams', '$location', 'dlap', ($scope, $routeParams, $location, dlap) ->
		$scope.returnUrl = unescape($routeParams.returnUrl)

		$scope.login = ->
			dlap.login(
				username: $scope.username
				password: $scope.password
			).then ->
				$location.path($scope.returnUrl or '/')
			, ->
				alert 'Error logging in'
	]
