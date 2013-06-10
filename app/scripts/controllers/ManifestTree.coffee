angular.module('manifestngApp')
	.controller 'ManifestTreeCtrl', ['$scope', 'dlap', 'xliManifest', ($scope, dlap, manifest) ->
		entityId = '2512573'
		$scope.select = (item)->
			$scope.selected = item
			$scope.content = manifest.getContent(entityId, item.id)
		dlap.login(
			username: 'dev/brady'
			password: 'agilix'
		).then ->
			$scope.dlapVersion = dlap.get('getstatus', null, process: (data)->
				data.response.status.version				
			)
			$scope.tree = manifest.get(entityId)
	]
