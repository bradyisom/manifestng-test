angular.module('manifestngApp', ['dlap'])
	.config ['$routeProvider', 'dlapProvider', ($routeProvider, dlapProvider) ->
		dlapProvider.init(
			urlBase: "http://localhost:1408/Dlap/"
		)
		$routeProvider
			.when '/',
				templateUrl: 'views/main.html'
				controller: 'MainCtrl'
			.otherwise
				redirectTo: '/'
  	]
