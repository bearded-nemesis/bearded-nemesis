describe 'AddSongToPlaylistController', ->
  beforeEach ->
    @scope = { model: { open: false } }
    @bus = jasmine.createSpyObj 'bus', ['subscribe', 'publish']
    @songService = jasmine.createSpyObj 'songService', ['search', 'addSongToPlaylist']
    @controller = new beard.impl.AddSongToPlaylistController @scope, @bus, @songService

  it 'should subscribe to channels on construction', ->
    expect(@bus.subscribe).toHaveBeenCalled()
    expect(@bus.subscribe.calls[0].args[0]).toEqual("playlist.ui.showAddSong");
    expect(@bus.subscribe.calls[1].args[0]).toEqual("playlist.ui.close");

  describe 'receiving open message', ->
    beforeEach ->
      @callback = @bus.subscribe.calls[0].args[1]

    it 'should set open to true when open message is received', ->
      @callback()
      expect(@scope.model.open).toBeTruthy

    it 'should save playlist passed in open message', ->
      playlist = {}
      @callback { playlist: playlist }
      expect(@scope.model.playlist).toEqual playlist

  describe 'searching for songs', ->
    it 'should call the song service with the current search term', ->
      @scope.model.songSearchTerm = "Foo"
      @controller.search()
      expect(@songService.search).toHaveBeenCalledWith { term: "Foo", mine: true }, jasmine.any(Function)

    it 'should set the songs property of the model', ->
      @controller.search()
      songs = [{ name: "Bar" }]
      @songService.search.mostRecentCall.args[1] songs
      expect(@scope.model.songs).toEqual songs

  describe 'adding songs', ->
    beforeEach ->
      @scope.model.playlist = { id: 2 }

    it 'should send an add song request when a song is selected', ->
      @controller.addSong 6
      expect(@songService.addSongToPlaylist).toHaveBeenCalledWith { playlistId: 2, songId: 6 }, jasmine.any(Function)

    it 'should clear the song search term after a song is added', ->
      @scope.model.songSearchTerm = "Foo"
      @controller.addSong 6
      @songService.addSongToPlaylist.mostRecentCall.args[1]()
      expect(@scope.model.songSearchTerm).toEqual ""

    it 'should publish a song added to playlist message', ->
      @controller.addSong 6
      @songService.addSongToPlaylist.mostRecentCall.args[1]()
      expect(@bus.publish).toHaveBeenCalledWith "playlist.songAdded", { playlistId: 2, songId: 6 }

  describe 'closing the ui', ->
    it 'should set open to false when close is called', ->
      @scope.model.open = true
      @controller.close()
      expect(@scope.model.open).toBeFalsy()

    it 'should close when it receives a close message', ->
      @scope.model.open = true
      @bus.subscribe.calls[1].args[1]()
      expect(@scope.model.open).toBeFalsy()