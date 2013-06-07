angular.module('dlap').factory 'xliManifest', ($http, $q, dlap) ->
	{
		get: (entityId)->
			dlap.get('getmanifest',
				entityid: entityId
			, process: (data)->
				data.response.manifest
			)
	}
