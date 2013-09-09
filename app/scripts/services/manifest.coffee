class Manifest
	constructor: (data, $rootScope)->
		angular.extend(@, data)
		$rootScope.$watch(=>
			@
		, (newVal, oldVal) =>
			count = 0
			@walk (item)->
				count++
			@itemCount = count
		, true)

	walk: (f)->
		_walk = (item)->
			f(item)
			if(item.item?.length)
				_.each item.item, _walk
		_.each @item[0].item, _walk

	getDataValue: (name)->
		@data?[name]?.$value

angular.module('xli-ng').factory 'xliManifest', ['$http', '$q', '$rootScope', 'dlap', ($http, $q, $rootScope, dlap) ->
	get: (entityId)->
		dlap.get('getmanifest',
			entityid: entityId
		, process: (data)->
			new Manifest(data.response.manifest, $rootScope)
			# manifest = XLI.createModel 'Manifest',
			# 	values: data.response.manifest
			# manifest
		)

	getContent: (enrollmentId, itemId)->
		dlap.get('navigateitem',
			enrollmentId: enrollmentId
			itemId: itemId
		, process: (data)->
			data.response.navigate
		)
]
