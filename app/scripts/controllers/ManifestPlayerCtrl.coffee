angular.module('manifestngApp')
	.controller 'ManifestPlayerCtrl', ['$scope', '$routeParams', 'dlap', 'xliManifest', ($scope, $routeParams, dlap, manifest) ->
		$scope.enrollmentId = $routeParams.enrollmentId
		$scope.dlapVersion = dlap.get('getstatus', null, process: (data)->
			data.response.status.version
		)
		manifest.get($scope.enrollmentId).then (manifest)->
			$scope.manifest = manifest

		$scope.addItem = ->
			$scope.manifest.item[0].item.push {
				data:
					title:
						$value: $scope.newItemTitle
				item: [{
					data:
						title:
							$value: 'Child 1'
				},{
					data:
						title:
							$value: 'Child 2'
				},{
					data:
						title:
							$value: 'Child 3'
				}]
			}
			$scope.newItemTitle = ''
	]
