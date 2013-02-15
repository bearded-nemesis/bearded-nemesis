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
        .when('/playlists/:id/songs', {templateUrl: '/playlists/songs.html', controller: "PlaylistSongsCtrl"})
        .when('/playlists/:id/play', {templateUrl: '/playlists/play.html', controller: "PlaylistPlayCtrl"})
        .otherwise({redirectTo: '/playlists'})
    ])

window.Beard =
  Widgets: {}
  Models: {}
  Controllers: {}

Beard.Widgets.Songs = {}
Beard.Models.Songs = {}