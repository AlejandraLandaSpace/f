class DashboardController < ApplicationController
  before_action(:force_user_sign_in)

  def index
    # @posts = Post.all.order({ :created_at => :desc })
    @q = Post.ransack(params[:q])
    @posts = @q.result
    render({ :template => "dashboard/index.html.erb" })
  end
end
