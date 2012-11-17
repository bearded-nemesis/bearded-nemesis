module ApplicationHelper
  def is_user_admin?
    puts current_user
    (current_user) ? current_user.is_admin? : false
  end

  def avatar_url(user, size)
    if user.respond_to? :avatar_url
      user.avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "//gravatar.com/avatar/#{gravatar_id}.png?s=#{size || 48}"
    end
  end
end
