angular.module('manifestngApp')
	.controller 'HomeCtrl', ['$scope', '$routeParams', '$location', 'dlap', 'xliEnrollment', ($scope, $routeParams, $location, dlap, enrollments) ->
		$scope.enrollments = enrollments.getUserEnrollmentList()
	]
