class PlaylistService
  constructor: (@$resource) ->
    @playlist = $resource '/playlists/:playlistId.json'
    @songs = $resource '/playlists/:playlistId/songs.json'
  get: (id, callback) =>
    @playlist.get id, callback
  songs: (id, callback) =>
    @songs.query id, callback



window.beard.services.factory(
  'performanceService'
  [                                    # The all-important factory array!
    '$resource'                        # The *name* of the dependency that we'll need
    ($resource)->                       # all dependencies are passed as functions
      $resource '/performances/:id.json'
  ]
)