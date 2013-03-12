class @beard.impl.PlaylistPlayersService
  constructor: (@$http) ->

  query: (id, callback) =>
    @$http.get("/playlists/#{id}/users.json").success callback

  delete: (id, user_id) =>
    @$http.get "/playlists/#{id}/users/#{user_id}"

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