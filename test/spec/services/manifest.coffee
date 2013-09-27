'use strict'

describe 'Service: manifest', () ->

  # load the service's module
  beforeEach module 'manifestngApp'

  # instantiate service
  manifest = {}
  beforeEach inject (xliManifest) ->
    manifest = xliManifest

  it 'should do something', () ->
    expect(!!manifest).toBe true;
