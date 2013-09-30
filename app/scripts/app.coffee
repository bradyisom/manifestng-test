app = angular.module('manifestngApp', ['xli-ng', 'ui'])

app.config ['$routeProvider', ($routeProvider) ->

		_.mixin(_.str.exports())

		$routeProvider
			.when '/course/:enrollmentId',
				templateUrl: 'views/main.html'
				controller: 'MainCtrl'
			.when '/home',
				templateUrl: 'views/home.html'
				controller: 'HomeCtrl'
			.when '/logout',
				templateUrl: 'views/login.html'
				public: true
			.when '/login',
				templateUrl: 'views/login.html'
				public: true
			.when '/login/:returnUrl',
				templateUrl: 'views/login.html'
				public: true
			.otherwise
				redirectTo: '/home'
  	]

app.run ['$rootScope', '$location', 'dlap', ($rootScope, $location, dlap)->
		# Prevent users from going to unauthenticated parts of the app
		$rootScope.$on '$routeChangeStart', (event, next, current)->
			if dlap.isLoggedIn() and _.startsWith(next.$$route?.templateUrl, 'views/login.html')
				dlap.logout()
				$location.path("/login")
			else if not dlap.isLoggedIn() and not next.$$route?.public
				$location.path("/login/#{encodeURIComponent($location.$$path)}")
		# Start DLAP module
		dlap.start(
			urlBase: "http://brighton.agilix.com/"
		)
	]
