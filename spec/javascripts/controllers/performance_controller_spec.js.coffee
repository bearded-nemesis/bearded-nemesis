describe 'PerformanceController', ->
  it 'should set defaults in the constructor', ->
    scope = {}
    service = {}
    impl = window.beard.impl

    controller = new impl.PerformanceController scope, service, null
    expect(scope.linkText).toEqual("Next")
