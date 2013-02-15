describe 'PlaylistListController', ->
  beforeEach ->
    @scope = {}
    @playlistService = jasmine.createSpyObj 'playlistService', ['query']
    @controller = new beard.impl.PlaylistListController @scope, @playlistService

  describe "constructor", ->
    it 'should query playlist service', ->
      expect(@playlistService.query).toHaveBeenCalled()

    it 'should set the playlists property to the returned list', ->
      data = [{id: 1}, {id:2}]
      @playlistService.query.mostRecentCall.args[0] data
      expect(@scope.playlists).toEqual data