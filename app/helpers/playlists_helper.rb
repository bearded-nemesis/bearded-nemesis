module PlaylistsHelper
  def player_option(user)
    user_select_option(@playlist.players.map{|x| x.user}, user)
  end

  def instrument_select_list(playlist_song, player)
    selectedInstrument = playlist_song.instrument_for player.user

    select_tag "#{player.user.email}[#{playlist_song.song.name}]", options_for_select(ApplicationController::INSTRUMENTS_WITH_PRO, selectedInstrument),
               :include_blank => true, :class => "instrument-select", "data-player" => player.id, "data-url" => playlist_song_path(playlist_song)
  end
end
