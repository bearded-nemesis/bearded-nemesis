module UsersHelper
  def add_friend_link(user)
    return if @friends.any? {|friend| friend == user}
    link_to "Add Friend", friendships_path(:friend_id => user), :method => :post, "data-user-id" => user.id
  end
end
