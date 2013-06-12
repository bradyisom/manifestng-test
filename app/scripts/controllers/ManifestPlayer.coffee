angular.module('manifestngApp')
	.controller 'ManifestPlayerCtrl', ['$scope', '$routeParams', 'dlap', 'xliManifest', ($scope, $routeParams, dlap, manifest) ->
		$scope.enrollmentId = $routeParams.enrollmentId
		$scope.$on('item:select', (event, args)->
			item = args[0]
			$scope.selected = item
			$scope.content = manifest.getContent($scope.enrollmentId, item.id)
		)
		dlap.login(
			username: 'dev/brady'
			password: 'agilix'
		).then ->
			$scope.dlapVersion = dlap.get('getstatus', null, process: (data)->
				data.response.status.version				
			)
			$scope.manifest = manifest.get($scope.enrollmentId)
	]
