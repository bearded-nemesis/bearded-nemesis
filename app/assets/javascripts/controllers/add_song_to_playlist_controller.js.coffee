class @beard.impl.AddSongToPlaylistController
  constructor: (@$scope, @bus, @songService) ->
    @bus.subscribe "playlist.ui.showAddSong", this._showWindow
    @bus.subscribe "playlist.ui.close", this.close

  search: =>
    @songService.search { term: @$scope.model.songSearchTerm, mine: true },
      this._updateSongs

  addSong: (songId) =>
    data = { playlistId: @$scope.model.playlist.id, songId: songId }
    @songService.addSongToPlaylist data, =>
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
    'bus'
    beard.impl.AddSongToPlaylistController
  ]
)