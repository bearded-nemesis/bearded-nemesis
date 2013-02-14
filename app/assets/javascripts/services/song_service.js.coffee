class @beard.impl.SongService
  constructor: (@$http) ->

  search: (data, callback) =>
    @$http.get("/songs/search/#{data.term}?mine=#{data.mine}").success callback

  addSongToPlaylist: (playlistId, songId, callback) =>
    @$http.post("/playlist_song", { playlist_id: playlistId, song_id: songId }).success callback

# Register
window.beard.services.factory(
  'songService'
  [
    '$http'
    ($http) ->
      new beard.impl.SongService $http
  ]
)