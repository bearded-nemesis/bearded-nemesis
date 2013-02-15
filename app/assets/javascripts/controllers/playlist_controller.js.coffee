class @beard.impl.PlaylistController
  constructor: (@$scope, @bus, @playlistService, $routeParams) ->
    @$scope.showAddSong = this.showAddSong
    @bus.subscribe "playlist.songAdded", this._addSong

    @playlistService.get { id: $routeParams.id },
      this._updatePlaylist

  showAddSong: =>
    @bus.publish "playlist.ui.showAddSong",
      { playlist: @$scope.playlist }

  removeSong: (songId) =>
    data = { playlistId: @$scope.playlist.id, songId: songId }
    @playlistService.removeSongFromPlaylist @$scope.playlist.id, songId, =>
      @bus.publish "playlist.songRemoved", data

  _addSong: (data) =>
    @$scope.playlist.songs.push data.songId

  _updatePlaylist: (data) =>
    @$scope.playlist = data

window.beard.controllers.controller(
  'PlaylistCtrl'
  [
    '$scope'
    'busService'
    'playlistService'
    '$routeParams'
    beard.impl.PlaylistController
  ]
)