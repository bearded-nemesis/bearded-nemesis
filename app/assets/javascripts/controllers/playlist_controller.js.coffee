class @beard.impl.PlaylistController
  constructor: (@$scope, @bus) ->
    @$scope.showAddSong = this.showAddSong

  showAddSong: =>
    @bus.publish "playlist.ui.showAddSong",
      { "playlist": @$scope.model.playlist }

window.beard.controllers.controller(
  'PlaylistCtrl'
  [
    '$scope'
    'busService'
    beard.impl.PlaylistController
  ]
)