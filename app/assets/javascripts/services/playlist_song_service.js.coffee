window.beard.services.factory(
  'playlistSongService'
  [                                    # The all-important factory array!
    '$resource'                        # The *name* of the dependency that we'll need
    ($resource)->                       # all dependencies are passed as functions
      $resource '/playlists/:playlistId/song.json'
  ]
)