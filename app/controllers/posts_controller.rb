class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.last_three_posts
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
  end
end
