class DashboardController < ApplicationController
  def index
    matching_posts = Post.all

    @list_of_posts = matching_posts.order({ :created_at => :desc })
    if @current_user == nil
      redirect_to("/user_sign_in")
    else
      render({ :template => "dashboard/index.html.erb" })
    end
  end
end
