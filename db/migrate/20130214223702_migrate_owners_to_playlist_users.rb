class MigrateOwnersToPlaylistUsers < ActiveRecord::Migration
  def up
    playlists = Playlist.all
    playlists.each do |playlist|
      playlist.players.create user: playlist.user
      playlist.save
    end
  end

  def down
    playlists = Playlist.all
    playlists.each do |playlist|
      item = PlaylistUser.where playlist_id: playlist.id, user_id: playlist.user.id
      PlaylistUser.delete item
    end
  end
end
