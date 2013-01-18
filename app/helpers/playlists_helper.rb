module PlaylistsHelper
  def player_option(user)
    user_select_option(@playlist.users, user)
  end
end
