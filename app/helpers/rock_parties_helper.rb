module RockPartiesHelper
  def attendee_option(user)
    if @rock_party.users && @rock_party.users.include?(user)
      content_tag(:option, selected: "selected", value: user.id) do
        user.email
      end
    else
      content_tag(:option, value: user.id) do
        user.email
      end
    end
  end
end
