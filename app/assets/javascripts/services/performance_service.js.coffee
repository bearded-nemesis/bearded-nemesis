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



#($resource)->                       # all dependencies are passed as functions
#  $resource '/playlists/:playlistId/:action.json', {}, {
#  "get": { method: 'GET', params: { action: "" } },
#  "songs": { method: 'GET', params: { action: "songs" } }
#  }


#return $resource('/cakephp/demo_comments/:action/:id/:page/:limit:format', { id:'@id', 'page' : '@page', 'limit': '@limit' }, {
#'initialize' : { method: 'GET', params: { action : 'initialize', format: '.json' }, isArray : true },
#'save': { method: 'POST', params: { action: 'create', format: '.json' } },
#'query' : { method: 'GET', params: { action : 'read', format: '.json' } , isArray : true },
#'update': { method: 'PUT', params: { action: 'update', format: '.json' } },
#}