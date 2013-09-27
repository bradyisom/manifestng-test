angular.module('xli-ng', ['ngCookies'])
	.provider 'dlap', ->
		urlBase = ""
		cookieName = 'dlapCookie'
		token = null
		userInfo = null
		cachePrefix = 'xli'
		cacheLocal = false #Modernizr.localstorage

		@init = (options)->
			urlBase = options.urlBase if options?.urlBase
			if urlBase.lastIndexOf('/') != urlBase.length-1
				urlBase += '/'
			urlBase += 'cmd/'
			if options
				cookieName = options.cookieName if options.cookieName
				cachePrefix = options.cachePrefix if options.cachePrefix
				cacheLocal = !!options.cacheLocal if options.cacheLocal?

		getCacheKey = (config, options)->
			cmd = ''
			cmd = config.url.substr(urlBase.length) if _.startsWith(config.url, urlBase)
			params = JSON.stringify(_.omit(config.params, '_token'))
			options = JSON.stringify(options)
			cacheKey = "#{cachePrefix}|#{cmd}"
			cacheKey += "|#{params}" if params != '{}'
			cacheKey += "|#{options}" if options != '{}'
			# console.log 'cacheKey', cacheKey
			cacheKey

		checkCache = (cacheKey)->
			cacheVal = localStorage.getItem(cacheKey)
			return JSON.parse(cacheVal) if cacheVal
			return null

		setCache = (cacheKey, data)->
			localStorage.setItem(cacheKey, JSON.stringify(data))

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
				cacheKey = ''
				if cacheLocal and not options?.noCache
					cacheKey = getCacheKey config, options
					data = checkCache(cacheKey)
					if data
						deferred.resolve(data)
						return deferred.promise
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
							if cacheLocal and not options?.noCache
								# console.log 'adding cache', "#{cacheKey}: #{JSON.stringify(data)}"
								setCache(cacheKey, data)
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
