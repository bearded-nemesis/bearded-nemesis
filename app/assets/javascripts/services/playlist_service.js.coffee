class @beard.impl.PlaylistService
  constructor: (@$http) ->

  get: (data, callback) =>
    @$http.get("/playlists/#{data.id}").success callback

  query: (callback) =>
    @$http.get("/playlists").success callback

window.beard.services.factory(
  'playlistService'
  [
    '$http'
    ($http) ->
      new beard.impl.PlaylistService $http
  ]
)