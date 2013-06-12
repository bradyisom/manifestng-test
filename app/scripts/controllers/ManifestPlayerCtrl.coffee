angular.module('manifestngApp')
	.controller 'ManifestPlayerCtrl', ['$scope', '$routeParams', 'dlap', 'xliManifest', ($scope, $routeParams, dlap, manifest) ->
		$scope.enrollmentId = $routeParams.enrollmentId
		$scope.dlapVersion = dlap.get('getstatus', null, process: (data)->
			data.response.status.version				
		)
		$scope.manifest = manifest.get($scope.enrollmentId)
	]
