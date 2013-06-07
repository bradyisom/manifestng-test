'use strict'

angular.module('manifestngApp')
	.controller 'ManifestTreeCtrl', ['$scope', 'dlap', 'xliManifest', ($scope, dlap, manifest) ->
		dlap.login(
			username: 'dev/brady'
			password: 'agilix'
		).then ->
			$scope.dlapVersion = dlap.get('getstatus', null, process: (data)->
				data.response.status.version				
			)
			$scope.tree = manifest.get('2512573')
	]
