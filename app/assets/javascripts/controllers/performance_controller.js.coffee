class window.beard.impl.PerformanceController
  constructor: (@$scope, performanceService, @$http) ->
    @$scope.song = "name": "Foo bar!"
    @$scope.linkText = "Next"
    @$scope.rate = this.rate
    @$scope.playlist
    @$scope.currentSong
    @$scope.currentSongIndex

    @$scope.load = (id) =>
      data = performanceService.get {"id": id}, =>
        @$scope.playlist = data
        @$scope.currentSongIndex = 0
        @$scope.currentSong = @$scope.playlist.songs[0]

  rate: =>
    data = { song: @$scope.currentSong.id, rating: @$scope.currentSong.rating.value }

    post = @$http.post "/performances/" + @$scope.playlist.id + "/rate", data
    post.success () =>
      @$scope.currentSongIndex++

      if @$scope.currentSongIndex == @$scope.playlist.songs.length
        location.href = "/playlists/#{@$scope.playlist.id}"
        return

      if @$scope.currentSongIndex == @$scope.playlist.songs.length - 1
        @$scope.linkText = "Finish"

      @$scope.currentSong = @$scope.playlist.songs[@$scope.currentSongIndex]



window.beard.controllers.controller(
  'PerformanceCtrl'                          # Name of the controller
  [                              # The factory array again
    '$scope'                     # The controller has two dependencies. Angular's '$scope', and ..
    'performanceService'            # The date displayer service
    '$http'
    beard.impl.PerformanceController

  ]
)