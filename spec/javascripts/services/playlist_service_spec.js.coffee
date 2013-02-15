describe 'PlaylistService', ->
  beforeEach ->
    @httpResult = jasmine.createSpyObj 'httpResult', ['success']
    @http = jasmine.createSpyObj 'http', ['get', 'post']
    @http.get.andReturn @httpResult
    @http.post.andReturn @httpResult
    @service = new beard.impl.PlaylistService @http

  describe 'query', ->
    it 'should call get with the correct parameters', ->
      tempFunction = ->
      @service.query tempFunction
      expect(@http.get).toHaveBeenCalledWith "/playlists"
      expect(@httpResult.success).toHaveBeenCalledWith tempFunction

  describe 'get', ->
    it 'should call get with the correct parameters', ->
      tempFunction = ->
      @service.get {id: 6}, tempFunction
      expect(@http.get).toHaveBeenCalledWith "/playlists/6"
      expect(@httpResult.success).toHaveBeenCalledWith tempFunction
