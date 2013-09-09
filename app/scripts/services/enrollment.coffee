angular.module('xli-ng').factory 'xliEnrollment', ['$http', '$q', 'dlap', ($http, $q, dlap) ->
	{
		getUserEnrollmentList: (userId)->
			dlap.get('getuserenrollmentlist2',
				userid: userId or dlap.getUser()?.userid
			, process: (data)->
				data.response.enrollments.enrollment
			)
	}
]
