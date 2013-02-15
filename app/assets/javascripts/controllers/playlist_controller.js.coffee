class @beard.impl.PlaylistController
  constructor: (@$scope, @bus, @playlistService) ->
    @$scope.showAddSong = this.showAddSong
    @bus.subscribe "playlist.songAdded", this._addSong

    @playlistService.get { id: @$scope.model.playlist.id },
      this._updatePlaylist

  showAddSong: =>
    @bus.publish "playlist.ui.showAddSong",
      { "playlist": @$scope.model.playlist }

  removeSong: (songId) =>
    data = { playlistId: @$scope.model.playlist.id, songId: songId }
    @playlistService.removeSongFromPlaylist @$scope.model.playlist.id, songId, =>
      @bus.publish "playlist.songRemoved", data

  _addSong: (data) =>
    @$scope.model.playlist.songs.push data.songId

  _updatePlaylist: (data) =>
    @$scope.model.playlist = data

window.beard.controllers.controller(
  'PlaylistCtrl'
  [
    '$scope'
    'busService'
    'playlistService'
    beard.impl.PlaylistController
  ]
)