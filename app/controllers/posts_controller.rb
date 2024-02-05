class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.includes(posts: :comments).find(params[:user_id])
    @post = Post.find(params[:id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @new_post = current_user.posts.new(post_params)
    @new_post.update(comments_counter: 0, likes_counter: 0)

    respond_to do |format|
      format.html do
        if @new_post.save
          redirect_to user_posts_path, notice: 'Success!'
        else
          render :new, alert: 'Error occured!'
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
