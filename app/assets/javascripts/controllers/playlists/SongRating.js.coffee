#class PlaySongRating
#  constructor: (@$scope, Rate, Playlists) ->
#    @$scope.song = "name": "Foo bar!"
#    @$scope.linkText = "Next >>"
#    @$scope.rate = this.rate
#    Playlists.get {"playlistId": 2}, =>
#      data = @$scope.playlist ->
#        @$scope.playlist = data
#
#  rate: =>
#    location.href = "/playlists/#{@$scope.playlist}" if @$scope.linkText == "Finish"
#    @$scope.linkText = "Finish"
#
#window.BeardNgControllers.controller(
#  "PlaySongRatingCtrl"
#  [           # The factory array again
#    '$scope'  # The controller has two dependencies. Angular's '$scope', and ..
#    'Rate'       # The date displayer service
#    'Playlists'
#    # The function that defines the controller
#    PlaySongRating
#  ]
#)




###############################################################################
### Step 1 - Create services
###
###############################################################################

class PlaylistService
  constructor: ($resource) ->
    $resource 'playlists/:playlistId.json'

# has a dependency on a date service
class DateDisplayerService

  constructor: (@dateService) ->
  display: ->
    "The date is #{@dateService.date()}.  Thanks!"

# A date service
class CurrentDateService

  date: ->
    new Date()

###############################################################################
### Step 2 - Registering services with a module
###
###############################################################################

# Define the module
#myServiceModule = angular.module(
#  'beard.services'               # every module needs a unqiue name
#  ['ngResource']                             # this module has no dependencies on other *modules*
#)

#myServiceModule.factory(
#  'dateService'                     # services need unique names as well
#  ()->                              # function that defines how to get an instance of the service
#    return new CurrentDateService
#)

#myServiceModule.factory(
#  'dateDisplayerService'
#  [                                    # The all-important factory array!
#    'dateService'                     # The *name* of the dependency that we'll need
#    (dateSrv)->                       # all dependencies are passed as functions
#      return new DateDisplayerService(dateSrv)
#  ]
#)



###############################################################################
### Step 3 - Injecting our services into a controller
###
###############################################################################

#myControllerModule = angular.module(
#  'beard.controllers',
#  ['beard.services']            # Important! our controller module depends on our services module!
#)





#angular.bootstrap(document, ['beard.controllers'])