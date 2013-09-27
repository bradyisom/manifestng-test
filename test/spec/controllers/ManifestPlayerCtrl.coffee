'use strict'

describe 'Controller: ManifestPlayerCtrl', () ->

	# load the controller's module
	beforeEach module 'manifestngApp'

	ManifestPlayerCtrl = {}
	scope = {}
	timeout = null
	xliManifest = null
	q = null
	deferred = null
	dlap =
    	get: -> null

	beforeEach ->
		xliManifest = {
			get: ->
				deferred = q.defer()
				deferred.promise
		}

	# Initialize the controller and a mock scope
	beforeEach inject ($controller, $rootScope, $q) ->
		scope = $rootScope.$new()
		q = $q
		ManifestPlayerCtrl = $controller 'ManifestPlayerCtrl', {
			$scope: scope
			dlap: dlap
			xliManifest: xliManifest
		}

	it 'should have an addItem function', () ->
		expect(typeof(scope.addItem)).toBe 'function';

	it 'should have the manifest', ($timeout)->
		manifest = {}
		deferred.resolve manifest
		scope.$root.$digest()
		expect(scope.manifest).toBe manifest
