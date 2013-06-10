class Manifest
	constructor: (data)->
		angular.extend(@, data)

	getDataValue: (name)->
		@data?[name]?.$value

angular.module('dlap').factory 'xliManifest', ($http, $q, dlap) ->
	{
		get: (entityId)->
			dlap.get('getmanifest',
				entityid: entityId
			, process: (data)->
				new Manifest(data.response.manifest)
			)
	}
