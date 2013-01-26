#angular.module('Beard.Services', ['ngResource']).
#  factory('Phone', function($resource){
#  return $resource('phones/:phoneId.json', {}, {
#  query: {method:'GET', params:{phoneId:'phones'}, isArray:true}
#  });
#});

#Beard.App.factory "Playlist.PlaySongRating", PlaySongRating

#class RateSong
#  constructor: ($resource) ->
#    $resource 'playlists/:playlistId.json', {}, {
#      query: {method: 'POST', params: {playlistId: 'playlist'}}
#    }

#window.BeardNg.factory "Rate", RateSong