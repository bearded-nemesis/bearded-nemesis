describe 'SongService', ->
  beforeEach ->
    @httpResult = jasmine.createSpyObj 'httpResult', ['success']
    @http = jasmine.createSpyObj 'http', ['get', 'post']
    @http.get.andReturn @httpResult
    @http.post.andReturn @httpResult
    @service = new beard.impl.SongService @http

  describe 'search', ->
    it 'call get with the correct parameters', ->
      tempFunction = ->
      @service.search { term: "Foo", mine: true }, tempFunction
      expect(@http.get).toHaveBeenCalledWith "/songs/search/Foo?mine=true"
      expect(@httpResult.success).toHaveBeenCalledWith tempFunction

  describe 'addSongToPlaylist', ->
    it 'should call post with the correct parameters', ->
      tempFunction = ->
      @service.addSongToPlaylist 8, 4, tempFunction
      expect(@http.post).toHaveBeenCalledWith "/playlists/8/addSong", { songId: 4 }
      expect(@httpResult.success).toHaveBeenCalledWith tempFunction
