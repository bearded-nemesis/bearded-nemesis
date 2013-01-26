class RatingService
  constructor: (@$resource) ->
    @collection = $resource '/ratings/:playlistId.json'
    @songs = $resource '/ratings/:playlistId/rating.json'
  get: (id, callback) =>
    @playlist.get id, callback
  songs: (id, callback) =>
    @songs.query id, callback

window.beard.services.factory(
  'ratingService'
  [                                    # The all-important factory array!
    '$resource'                        # The *name* of the dependency that we'll need
    ($resource)->                       # all dependencies are passed as functions
      $resource '/ratings/:id.json'
  ]
)