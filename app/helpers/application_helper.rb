module ApplicationHelper
  def is_user_admin?
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

  def get_menu_link(text, path, entity)
    content_tag "li", link_to(text, path), :class => ("active" unless entity != controller.controller_name)
  end

  def user_select_option(availableUsers, user)
    if availableUsers && availableUsers.include?(user)
      content_tag(:option, selected: "selected", value: user.id) do
        user.display_name
      end
    else
      content_tag(:option, value: user.id) do
        user.display_name
      end
    end
  end
end
