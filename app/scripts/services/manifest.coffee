class Manifest
	constructor: (data)->
		angular.extend(@, data)

	getDataValue: (name)->
		@data?[name]?.$value

angular.module('xli-ng').factory 'xliManifest', ($http, $q, dlap) ->
	get: (entityId)->
		dlap.get('getmanifest',
			entityid: entityId
		, process: (data)->
			# new Manifest(data.response.manifest)
			manifest = XLI.createModel 'Manifest',
				values: data.response.manifest
			manifest
		)

	getContent: (enrollmentId, itemId)->
		dlap.get('navigateitem',
			enrollmentId: enrollmentId
			itemId: itemId
		, process: (data)->
			data.response.navigate
		)
