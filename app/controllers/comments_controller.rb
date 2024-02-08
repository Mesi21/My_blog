class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(
      text: comment_params,
      user_id: current_user.id,
      post_id: @post.id
    )
    @comment.post_id = @post.id
    @comment.update_comments_counter
    if @comment.save
      redirect_to posts_path, notice: 'Comment created successfully!'
    else
      render :new, alert: 'Something went wrong!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
