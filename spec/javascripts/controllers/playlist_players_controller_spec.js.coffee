describe 'PlaylistController', ->
  beforeEach ->
    @scope = { }
    @routeParams = { id: 3 }
    @playlistPlayersService = jasmine.createSpyObj 'playlistPlaylistService', ['query', 'delete']
    @controller = new beard.impl.PlaylistPlayersController @scope, @playlistPlayersService, @routeParams

  describe 'constructor', ->
    it 'should call the playlist players service with the id', ->
      @controller
      expect(@playlistPlayersService.query).toHaveBeenCalledWith 3, jasmine.any(Function)

    it 'should set the players property of the model', ->
      @controller
      players = [ { id: 9, user_id: 3, name: 'bro@example.com', instrument: "pro_drums" } ]
      @playlistPlayersService.query.mostRecentCall.args[1] players
      expect(@scope.players).toEqual players

    it 'should set the available instruments', ->
      @controller
      expect(@scope.instruments).toContain "bass"
      expect(@scope.instruments).toContain "pro_bass"
      expect(@scope.instruments).toContain "guitar"

  describe 'remove', ->
    beforeEach ->
      @scope.players = [ { id: 9 }, { id: 6 } ]

    it 'should call delete on the service', ->
      @controller.delete 9
      expect(@playlistPlayersService.delete).toHaveBeenCalledWith 9

    it 'should remove the element from the players array', ->
      @controller.delete 9
      expect(@scope.players).not.toContain { id: 9 }
      expect(@scope.players).toContain { id: 6 }

    it 'should not call delete if player is not in collection', ->
      @controller.delete 12
      expect(@playlistPlayersService.delete).not.toHaveBeenCalled()

  #describe 'receiving an open message', ->
  #  beforeEach ->
  #    @callback = @bus.subscribe.calls[0].args[1]
#
#    it 'should add song passed in open message', ->
#      songId = 6
#      @callback { songId: songId }
#      expect(@scope.playlist.songs).toContain songId
#
#  describe 'removing songs', ->
#    it 'should send a remove song request when button is clicked', ->
#      @controller.removeSong 6
#      expect(@playlistService.removeSongFromPlaylist).toHaveBeenCalledWith 8, 6, jasmine.any(Function)
#
#  describe 'sending messages', ->
#    it 'should send message when ui is requested', ->
#      @controller.showAddSong()
#
#      expect(@bus.publish).toHaveBeenCalledWith "playlist.ui.showAddSong", {playlist: @scope.playlist}