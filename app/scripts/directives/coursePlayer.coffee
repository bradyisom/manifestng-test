angular.module('xli-ng').directive('coursePlayer', ['xliManifest', (manifest)->
		restrict: 'EA'
		templateUrl: 'views/courseplayer.html'
		replace: false
		scope: 
			manifest: '='
			enrollmentId: '='
		link: (scope, el, attrs)->
			scope.$on('item:select', (event, args)->
				item = args[0]
				scope.selected = item
				scope.content = manifest.getContent(scope.enrollmentId, item.id)
			)
	]
)