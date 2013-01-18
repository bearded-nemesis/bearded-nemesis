module RockPartiesHelper
  def attendee_option(user)
    user_select_option(@rock_party.users, user)
  end

  def get_event_datetime(eventDate)
    eventDate.strftime("%m/%d/%Y %I:%M %P") unless eventDate.nil?
  end

  def get_event_date(eventDate)
    eventDate.strftime("%m/%d/%Y") unless eventDate.nil?
  end

  def get_event_time(eventDate)
    eventDate.strftime("%I:%M %P") unless eventDate.nil?
  end
end
