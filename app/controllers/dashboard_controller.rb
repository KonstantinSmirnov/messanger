class DashboardController < ApplicationController
  def index
    if current_user.nil?
      redirect_to login_path
    else
      redirect_to user_messages_path(current_user)
    end
  end
end
