class @beard.impl.PlaylistPlayersController
  constructor: (@$scope, @playlistPlayerService, $routeParams) ->
    @playlistPlayerService.query $routeParams.id, (data) =>
      @$scope.players = data

window.beard.controllers.controller(
  'PlaylistPlayersCtrl'
  [
    '$scope'
    'playlistPlayerService'
    '$routeParams'
    beard.impl.PlaylistPlayersController
  ]
)