angular.module('xli-ng', ['ngCookies'])
	.provider 'dlap', ->
		urlBase = ""
		cookieName = 'dlapCookie'
		token = null
		userInfo = null

		@init = (options)->
			urlBase = options.urlBase if options?.urlBase
			if urlBase.lastIndexOf('/') != urlBase.length-1
				urlBase += '/'
			urlBase += 'cmd/'
			cookieName = options.cookieName if options?.cookieName

		providerGet = ($http, $q, $cookieStore) ->
			start: ->
				savedToken = $cookieStore.get cookieName
				if savedToken
					token = savedToken
				userInfo = JSON.parse(localStorage.getItem 'userInfo')

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
								$cookieStore.put cookieName, token
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

			isLoggedIn: ->
				!!token

			getUser: ->
					userInfo

			login: (credentials)->
				promise = @post('',
					request: angular.extend(credentials, cmd:'login')
				)
				promise.then (data)->
					userInfo = data.response.user
					localStorage.setItem 'userInfo', JSON.stringify(userInfo)
				promise

			logout: (credentials)->
				promise = @get('logout')
				promise.then ->
					token = null
					userInfo = null
					$cookieStore.remove cookieName
					localStorage.setItem 'userInfo', null
				promise
		providerGet.$inject = ['$http', '$q', '$cookieStore']

		@$get = providerGet
