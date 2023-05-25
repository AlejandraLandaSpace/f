class DashboardController < ApplicationController
  before_action(:force_user_sign_in)

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.page params[:page]
    render({ :template => "dashboard/index.html.erb" })
  end
end
