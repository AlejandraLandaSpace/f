class DashboardController < ApplicationController
  def index
    if @current_user == nil
      redirect_to("/user_sign_in")
    else
      render({ :template => "dashboard/index.html.erb" })
    end
  end
end
