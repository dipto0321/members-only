class CommentsController < ApplicationController
  before_action :logged_in_user
  
  def new
    # @comment = @commentable.comments
    @post_author = User.find_by(id: params[:user_id])
    @post = Post.find_by(id: params[:post_id])
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    @author = @commentable.class == Comment ? @comment.commentable.commentable.user : @comment.commentable.user
    @comment.save
    flash[:success] = "Comment sent"
    redirectlocation = @commentable.class == Comment ? @comment.commentable.commentable : @commentable
    redirect_to [@author, redirectlocation]
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
