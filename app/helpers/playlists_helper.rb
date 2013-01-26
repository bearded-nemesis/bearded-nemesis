module PlaylistsHelper
  def player_option(user)
    user_select_option(@playlist.users, user)
  end

  def instrument_select_list(playlist_song, player)
    selectedInstrument = ""

    ApplicationController::INSTRUMENTS.each do |instrument|
      if playlist_song.send("#{instrument}_rocker") == player
        selectedInstrument = instrument.to_s
      end
    end

    select_tag "#{player.email}[#{playlist_song.song.name}]", options_for_select(ApplicationController::INSTRUMENTS, selectedInstrument),
               :include_blank => true, :class => "instrument-select", "data-player" => player.id, "data-url" => playlist_song_path(playlist_song)
  end
end
