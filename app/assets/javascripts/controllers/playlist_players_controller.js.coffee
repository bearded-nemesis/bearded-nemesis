class @beard.impl.PlaylistPlayersController
  constructor: (@$scope, @playlistPlayerService, $routeParams) ->
    @$scope.instruments = ["bass", "pro_bass", "guitar", "pro_guitar",
      "drums", "pro_drums", "keyboard", "pro_keyboard", "vocals", "pro_vocals"]
    @$scope.availableInstruments = @$scope.instruments
    @$scope.playlistId = $routeParams.id

    @playlistPlayerService.query $routeParams.id, (data) =>
      @$scope.players = data
      @_updateAvailableInstruments()

  delete: (id) =>
    player = _.find @$scope.players, (player) ->
      player.id == id

    return unless player

    @$scope.players = _.without @$scope.players, player
    @_updateAvailableInstruments()
    @playlistPlayerService.delete id

  changeInstrument: (id) =>
    player = _.find @$scope.players, (player) ->
      player.id == id
    return unless player

    @_updateAvailableInstruments()
    @playlistPlayerService.update {id: id, instrument: player.instrument}

  addPlayer: =>
    player = _.find @$scope.players, (player) =>
      player.id == @$scope.newPlayer.id

    return if player

    @$scope.newPlayer.playlist_id = @$scope.playlistId

    @playlistPlayerService.new @$scope.newPlayer, (data) =>
      @$scope.players.push data
      @_updateAvailableInstruments()
      @$scope.newPlayer = {}

  _updateAvailableInstruments: =>
    @$scope.availableInstruments = _.difference @$scope.instruments, @$scope.players.map((item) -> item.instrument)

window.beard.controllers.controller(
  'PlaylistPlayersCtrl'
  [
    '$scope'
    'playlistPlayerService'
    '$routeParams'
    beard.impl.PlaylistPlayersController
  ]
)