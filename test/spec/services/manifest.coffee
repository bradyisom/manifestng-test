'use strict'

describe 'Service: manifest', () ->

  # load the service's module
  beforeEach module 'initApp'

  # instantiate service
  manifest = {}
  beforeEach inject (_manifest_) ->
    manifest = _manifest_

  it 'should do something', () ->
    expect(!!manifest).toBe true;
