module ApplicationHelper
  def is_user_admin?
    puts current_user
    (current_user) ? current_user.is_admin? : false
  end
end
