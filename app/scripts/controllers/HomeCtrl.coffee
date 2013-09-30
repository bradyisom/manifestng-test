angular.module('manifestngApp')
	.controller 'HomeCtrl', ['$scope', '$routeParams', '$location', 'dlap', 'xli-enrollment', ($scope, $routeParams, $location, dlap, enrollments) ->
		$scope.enrollments = enrollments.getUserEnrollmentList()
	]
