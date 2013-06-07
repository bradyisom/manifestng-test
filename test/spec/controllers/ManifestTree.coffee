'use strict'

describe 'Controller: ManifestTreeCtrl', () ->

  # load the controller's module
  beforeEach module 'initApp'

  ManifestTreeCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ManifestTreeCtrl = $controller 'ManifestTreeCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
