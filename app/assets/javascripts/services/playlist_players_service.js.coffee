class @beard.impl.PlaylistPlayersService
  constructor: (@$http) ->

  query: (id, callback) =>
    @$http.get("/playlists/#{id}/players.json").success callback

  delete: (id, user_id) =>
    @$http.delete "/playlists/#{id}/players/#{user_id}"

  update: (data) =>

  new: (data) =>



window.beard.services.factory(
  'playlistPlayersService'
  [
    '$http'
    ($http) ->
      new beard.impl.PlaylistPlayersService $http
  ]
)