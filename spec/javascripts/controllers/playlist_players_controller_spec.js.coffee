describe 'PlaylistController', ->
  beforeEach ->
    @scope = { }
    @routeParams = { id: 3 }
    @playlistPlayersService = jasmine.createSpyObj 'playlistPlaylistService', ['query', 'delete', 'update']
    @controller = new beard.impl.PlaylistPlayersController @scope, @playlistPlayersService, @routeParams

  describe 'constructor', ->
    it 'should call the playlist players service with the id', ->
      expect(@playlistPlayersService.query).toHaveBeenCalledWith 3, jasmine.any(Function)

    it 'should set the players property of the model', ->
      players = [ { id: 9, user_id: 3, name: 'bro@example.com', instrument: "pro_drums" } ]
      @playlistPlayersService.query.mostRecentCall.args[1] players
      expect(@scope.players).toEqual players

    it 'should set the available instruments', ->
      expect(@scope.instruments).toContain "bass"
      expect(@scope.instruments).toContain "pro_bass"
      expect(@scope.instruments).toContain "guitar"

  describe 'remove', ->
    beforeEach ->
      @players = [ { id: 9, instrument: "pro_drums" }, { id: 6, instrument: "guitar" } ]
      @playlistPlayersService.query.mostRecentCall.args[1] @players

    it 'should call delete on the service', ->
      @controller.delete 9
      expect(@playlistPlayersService.delete).toHaveBeenCalledWith 9

    it 'should remove the element from the players array', ->
      @controller.delete 9
      expect(@scope.players).not.toContain @players[0]
      expect(@scope.players).toContain @players[1]

    it 'should not call delete if player is not in collection', ->
      @controller.delete 12
      expect(@playlistPlayersService.delete).not.toHaveBeenCalled()

    it 'should re-insert the players instrument into the available instruments list', ->
      @controller.delete 9
      expect(@scope.availableInstruments).toContain "pro_drums"

  describe 'change instrument', ->
    beforeEach ->
      @players = [ { id: 9, instrument: "pro_drums" }, { id: 6, instrument: "guitar" } ]
      @playlistPlayersService.query.mostRecentCall.args[1] @players

    it "should not have used instruments in available instruments list", ->
      expect(@scope.availableInstruments).toContain "drums"
      expect(@scope.availableInstruments).not.toContain "pro_drums"
      expect(@scope.availableInstruments).not.toContain "guitar"

    it "should update the available instruments", ->
      @scope.players[0].instrument = "vocals"
      @controller.changeInstrument 9
      expect(@scope.availableInstruments).toContain "pro_drums"
      expect(@scope.availableInstruments).not.toContain "vocals"

    it "should call update with the new information", ->
      @scope.players[0].instrument = "vocals"
      @controller.changeInstrument 9
      expect(@playlistPlayersService.update).toHaveBeenCalledWith {id: 9, instrument: "vocals"}

    it 'should not call update if player is not in collection', ->
      @controller.changeInstrument 12
      expect(@playlistPlayersService.update).not.toHaveBeenCalled()

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