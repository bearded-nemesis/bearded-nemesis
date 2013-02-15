class @beard.impl.PlaylistListController
  constructor: (@$scope, @playlistService) ->
    @playlistService.query (data) =>
      @$scope.playlists = data

window.beard.controllers.controller(
  'PlaylistListCtrl'
  [
    '$scope'
    'playlistService'
    beard.impl.PlaylistListController
  ]
)