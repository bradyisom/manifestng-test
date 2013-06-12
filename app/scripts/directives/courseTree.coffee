angular.module('dlap').directive('courseTree', ->
	restrict: 'E'
	templateUrl: 'views/coursetree.html'
	replace: true
	scope: 
		manifest: '='
	link: (scope, el, attrs)->
		scope.selectedTreeItem = null
		scope.select = (item)->
			scope.selectedTreeItem = item
			scope.$emit('item:select', [item])
)