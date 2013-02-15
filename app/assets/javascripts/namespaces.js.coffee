#angular.module("Beard.Ratings", ['ngResource'])
#window.BeardNgServices = angular.module("Beard.Services", ["ngResource"])
#window.BeardNgControllers = angular.module("Beard.Controllers", ["Beard.Services"])
#window.BeardNg = angular.module("Beard", ["Beard.Controllers", "Beard.Services"])

#angular.module("Beard.Controllers", [])
#angular.module("Beard.Services", [])

window.beard = {
  services: angular.module "beard.services", ["ngResource"]
  controllers: angular.module "beard.controllers", ["beard.services"]
  impl: {}
}

angular.module("beard", ['beard.services', 'beard.controllers'])
  .config([
    '$routeProvider'
    ($routeProvider) ->
      $routeProvider
        .when('/playlists', {templateUrl: '/playlists/list.html', controller: "PlaylistListCtrl"})
        .when('/playlists/:id', {templateUrl: '/playlists/detail.html', controller: "PlaylistCtrl"})
        .when('/playlists/:id/players', {templateUrl: '/playlists/players.html', controller: "PlaylistPlayersCtrl"})
        .otherwise({redirectTo: '/playlists'})
    ])

window.Beard =
  Widgets: {}
  Models: {}
  Controllers: {}

Beard.Widgets.Songs = {}
Beard.Models.Songs = {}