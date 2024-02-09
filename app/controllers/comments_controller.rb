class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    @comment.update_comments_counter
    if @comment.save
      redirect_to posts_path, notice: 'Comment created successfully!'
    else
      render :new, alert: 'Something went wrong!'
    end
  end

  def destroy
    @user = current_user
    # @post = Post.find(params[:post_id])
    @comment_to_destroy = Comment.find(params[:id])

    if @comment_to_destroy.user == @user
      @comment_to_destroy.destroy
      flash[:notice] = 'Comment deleted succesfully'
    end
    
    redirect_to user_post_path(@user)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
