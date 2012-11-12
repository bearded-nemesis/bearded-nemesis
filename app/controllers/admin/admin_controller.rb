class Admin::AdminController < ApplicationController
  before_filter :ensure_admin

  private

  def ensure_admin
    redirect_to new_user_session_path unless current_user.is_admin
  end
end