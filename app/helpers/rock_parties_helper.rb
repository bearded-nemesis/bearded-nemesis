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

  def get_event_datetime(eventDate)
    return eventDate.strftime("%m/%d/%Y %I:%M %P") unless eventDate.nil?
  end

  def get_event_date(eventDate)
    return eventDate.strftime("%m/%d/%Y") unless eventDate.nil?
  end

  def get_event_time(eventDate)
    return eventDate.strftime("%I:%M %P") unless eventDate.nil?
  end
end
