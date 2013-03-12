describe 'PlaylistPlayersService', ->
  beforeEach ->
    @httpResult = jasmine.createSpyObj 'httpResult', ['success']
    @http = jasmine.createSpyObj 'http', ['get', 'post', 'delete']
    @http.get.andReturn @httpResult
    @http.post.andReturn @httpResult
    @service = new beard.impl.PlaylistPlayersService @http

  describe 'query', ->
    it 'should call query with the correct parameters', ->
      tempFunction = ->
      @service.query 6, tempFunction
      expect(@http.get).toHaveBeenCalledWith "/playlists/6/users.json"
      expect(@httpResult.success).toHaveBeenCalledWith tempFunction

  describe 'delete', ->
    it 'should call get with the correct parameters', ->
      @service.delete {id: 6}, tempFunction
      expect(@http.delete).toHaveBeenCalledWith "/playlists/6/users/9"

  describe 'update', ->
    it 'should call put with the correct parameters', ->
      @service.update {}
    #  tempFunction = ->
    #  @service.get {id: 6}, tempFunction
    #  expect(@http.get).toHaveBeenCalledWith "/playlists/6"
    #  expect(@httpResult.success).toHaveBeenCalledWith tempFunction

  describe 'new', ->
    #it 'should call get with the correct parameters', ->
    #  tempFunction = ->
    #  @service.get {id: 6}, tempFunction
    #  expect(@http.get).toHaveBeenCalledWith "/playlists/6"
    #  expect(@httpResult.success).toHaveBeenCalledWith tempFunction

