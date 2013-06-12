angular.module('manifestngApp')
	.controller 'ManifestPlayerCtrl', ['$scope', '$routeParams', 'dlap', 'xliManifest', ($scope, $routeParams, dlap, manifest) ->
		$scope.enrollmentId = $routeParams.enrollmentId
		dlap.login(
			username: 'dev/brady'
			password: 'agilix'
		).then ->
			$scope.dlapVersion = dlap.get('getstatus', null, process: (data)->
				data.response.status.version				
			)
			$scope.manifest = manifest.get($scope.enrollmentId)
	]
