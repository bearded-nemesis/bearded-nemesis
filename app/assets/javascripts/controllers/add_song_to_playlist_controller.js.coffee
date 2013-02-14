class @beard.impl.AddSongToPlaylistController
  constructor: (@$scope, @bus, @songService) ->
    @$scope.model = { open: false }
    @$scope.search = this.search
    @$scope.addSong = this.addSong
    @$scope.close = this.close
    @bus.subscribe "playlist.ui.showAddSong", this._showWindow
    @bus.subscribe "playlist.ui.close", this.close

  search: =>
    unless @$scope.model.songSearchTerm and @$scope.model.songSearchTerm.length > 0
      @$scope.model.songs = []
    else
      @songService.search { term: @$scope.model.songSearchTerm, mine: true },
        this._updateSongs

  addSong: (songId) =>
    data = { playlistId: @$scope.model.playlist.id, songId: songId }
    @songService.addSongToPlaylist @$scope.model.playlist.id, songId, =>
      @$scope.model.songSearchTerm = ""
      @bus.publish "playlist.songAdded", data

  close: =>
    @$scope.model.open = false

  _showWindow: (data) =>
    @$scope.model.open = true
    @$scope.model.playlist = data.playlist if data and data.playlist

  _updateSongs: (data) =>
    @$scope.model.songs = data

window.beard.controllers.controller(
  'AddSongToPlaylistCtrl'
  [
    '$scope'
    'busService'
    'songService'
    beard.impl.AddSongToPlaylistController
  ]
)