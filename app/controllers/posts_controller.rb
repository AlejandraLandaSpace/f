class PostsController < ApplicationController
  def index
    matching_posts = Post.all

    @list_of_posts = matching_posts.order({ :created_at => :desc })

    render({ :template => "posts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_posts = Post.where({ :id => the_id })

    @the_post = matching_posts.at(0)

    render({ :template => "posts/show.html.erb" })
  end

  def create
    the_post = Post.new
    the_post.description = params.fetch("query_description")
    the_post.user_id = @current_user.id
    the_post.photo = params.fetch("query_photo")

    if the_post.valid?
      the_post.save
      redirect_to("/dashboard", { :notice => "Post created successfully." })
    else
      redirect_to("/dashboard", { :alert => the_post.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_post = Post.where({ :id => the_id }).at(0)

    the_post.description = params.fetch("query_description")
    the_post.user_id = params.fetch("query_user_id")

    if the_post.valid?
      the_post.save
      redirect_to("/dashboard/#{the_post.id}", { :notice => "Post updated successfully."} )
    else
      redirect_to("/dashboard/#{the_post.id}", { :alert => the_post.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_post = Post.where({ :id => the_id }).at(0)

    the_post.destroy

    redirect_to("/dashboard", { :notice => "Post deleted successfully."} )
  end
end
