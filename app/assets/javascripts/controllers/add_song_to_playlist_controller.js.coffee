class @beard.impl.AddSongToPlaylistController
  constructor: (@$scope, @bus) ->
    @$scope.showAddSong = this.showAddSong

  showAddSong: =>
    @bus.publish "playlist.ui.showAddSong",
      { "playlist": @$scope.model.playlist }

window.beard.controllers.controller(
  'AddSongToPlaylistCtrl'
  [
    '$scope'
    'bus'
    beard.impl.AddSongToPlaylistController
  ]
)