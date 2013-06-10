angular.module('dlap', [])
	.provider 'dlap', ->
		urlBase = ""
		token = null

		@init = (options)->
			urlBase = options.urlBase if options?.urlBase
			if urlBase.lastIndexOf('/') != urlBase.length-1
				urlBase += '/'
			urlBase += 'cmd/'

		@$get = ($http, $q) ->
			request: (config, options)->
				deferred = $q.defer()
				config.params or= {}
				angular.extend config.params, _token:token
				$http(config)
					.success (data)->
						if(!options?.ignoreResponseCode and 
								data.response.code != 'OK')
							deferred.reject(data)
						else
							if data?.response?._token
								token = data.response._token
							if options?.process
								data = options.process(data)
							deferred.resolve(data)
					.error (data, status, headers, config)->
						deferred.reject(data)
				deferred.promise

			get: (cmd, params, options)->
				@request(
					url: "#{urlBase}#{cmd}"
					method: 'GET'
					params: params
				, options)
			post: (cmd, data, options)->
				@request(
					url: "#{urlBase}#{cmd}"
					method: 'POST'
					data: data
				, options)
			login: (credentials)->
				@post('', 
					request: angular.extend(credentials, cmd:'login')
				)
