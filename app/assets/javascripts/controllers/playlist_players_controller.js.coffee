class @beard.impl.PlaylistPlayersController
  constructor: (@$scope, @playlistPlayerService, $routeParams) ->
    @$scope.instruments = ["bass", "pro_bass", "guitar", "pro_guitar",
      "drums", "pro_dums", "keyboard", "pro_keyboard", "vocals", "pro_vocals"]
    @playlistPlayerService.query $routeParams.id, (data) =>
      @$scope.players = data

  delete: (id) =>
    player = _.find @$scope.players, (player) ->
      player.id == id

    return unless player

    @$scope.players = _.without @$scope.players, player
    @playlistPlayerService.delete id

window.beard.controllers.controller(
  'PlaylistPlayersCtrl'
  [
    '$scope'
    'playlistPlayerService'
    '$routeParams'
    beard.impl.PlaylistPlayersController
  ]
)