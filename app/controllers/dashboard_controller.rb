class DashboardController < ApplicationController
  before_action(:force_user_sign_in)

  def index
    @posts = Post.all.order({ :created_at => :desc })
    render({ :template => "dashboard/index.html.erb" })
  end
end
