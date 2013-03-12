describe 'PlaylistController', ->
  beforeEach ->
    @scope = { }
    @routeParams = { id: 3 }
    @playlistPlayersService = jasmine.createSpyObj 'playlistPlaylistService', ['query', 'delete', 'update', 'new']
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

    it 'should save the playlist id', ->
      expect(@scope.playlistId).toEqual 3

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

  describe 'adding players', ->
    beforeEach ->
      @scope.newPlayer = { user_id: 4, instrument: "vocals" }
      @players = [ { id: 9, instrument: "pro_drums" }, { id: 6, instrument: "guitar" } ]
      @playlistPlayersService.query.mostRecentCall.args[1] @players

    it "should call new on the service", ->
      @controller.addPlayer()
      expect(@playlistPlayersService.new).toHaveBeenCalledWith { playlist_id: 3, user_id: 4, instrument: "vocals" }, jasmine.any(Function)

    it "should add the new player to the list", ->
      @controller.addPlayer()
      new_player = { id: 91, user_id: 4, instrument: "vocals" }
      @playlistPlayersService.new.mostRecentCall.args[1] new_player
      expect(@scope.players).toContain new_player

    it "should remove the new player's instrument from the available list", ->
      @controller.addPlayer()
      new_player = { id: 91, user_id: 4, instrument: "vocals" }
      @playlistPlayersService.new.mostRecentCall.args[1] new_player
      expect(@scope.availableInstruments).not.toContain "vocals"

    it "should not allow existing player to be added", ->
      @scope.newPlayer.user_id = 6
      @controller.addPlayer()
      expect(@playlistPlayersService.new).not.toHaveBeenCalled

    it "should clear the new player variable", ->
      @controller.addPlayer()
      @playlistPlayersService.new.mostRecentCall.args[1] @players
      expect(@scope.newPlayer).toEqual {}