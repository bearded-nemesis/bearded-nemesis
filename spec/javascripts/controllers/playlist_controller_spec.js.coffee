describe 'PlaylistController', ->
  beforeEach ->
    @scope = { model: { playlist: { id: 3, songs: [] } } }
    @playlistService = jasmine.createSpyObj 'playlistService', ['get', 'removeSongFromPlaylist']
    @bus = jasmine.createSpyObj 'bus', ['publish', 'subscribe']
    @controller = new beard.impl.PlaylistController @scope, @bus, @playlistService

  describe 'constructor', ->
    it 'should call the playlist service with the id', ->
      @controller
      expect(@playlistService.get).toHaveBeenCalledWith { id: 3 }, jasmine.any(Function)

    it 'should set the playlist property of the model', ->
      @controller
      playlist = { id: 3, user: 'bro@example.com' }
      @playlistService.get.mostRecentCall.args[1] playlist
      expect(@scope.model.playlist).toEqual playlist

  describe 'receiving an open message', ->
    beforeEach ->
      @callback = @bus.subscribe.calls[0].args[1]

    it 'should add song passed in open message', ->
      songId = 6
      @callback { songId: songId }
      expect(@scope.model.playlist.songs).toContain songId

  describe 'removing songs', ->
    it 'should send a remove song request when button is clicked', ->
      @controller.removeSong 6
      expect(@playlistService.removeSongFromPlaylist).toHaveBeenCalledWith 3, 6, jasmine.any(Function)

  describe 'sending messages', ->
    it 'should send message when ui is requested', ->
      @controller.showAddSong()

      expect(@bus.publish).toHaveBeenCalled()
      expect(@bus.publish.mostRecentCall.args[0]).toEqual("playlist.ui.showAddSong");
      expect(@bus.publish.mostRecentCall.args[1].playlist.id).toEqual(3)