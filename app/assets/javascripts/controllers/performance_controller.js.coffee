class PerformanceController
  constructor: (@$scope, performanceService, @$http) ->
    @$scope.song = "name": "Foo bar!"
    @$scope.linkText = "Next >>"
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
    data = {}
    data[@$scope.currentSong.instrument] = @$scope.currentSong.rating.value

    @$http.post "/songs/" + @$scope.currentSong.id + "/ratings", data

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
    PerformanceController

  ]
)