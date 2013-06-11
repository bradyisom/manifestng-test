angular.module('manifestngApp')
	.controller 'ManifestTreeCtrl', ['$scope', 'xliManifest', ($scope, manifest) ->
		$scope.selectedTreeItem = null
		$scope.select = (item)->
			$scope.selectedTreeItem = item
			$scope.$emit('item:select', [item])
	]
