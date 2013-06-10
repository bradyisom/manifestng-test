angular.module('manifestngApp')
	.controller 'ManifestTreeCtrl', ['$scope', '$routeParams', 'dlap', 'xliManifest', ($scope, $routeParams, dlap, manifest) ->
		enrollmentId = $routeParams.enrollmentId
		$scope.select = (item)->
			$scope.selected = item
			$scope.content = manifest.getContent(enrollmentId, item.id)
		dlap.login(
			username: 'dev/brady'
			password: 'agilix'
		).then ->
			$scope.dlapVersion = dlap.get('getstatus', null, process: (data)->
				data.response.status.version				
			)
			$scope.tree = manifest.get(enrollmentId)
	]
