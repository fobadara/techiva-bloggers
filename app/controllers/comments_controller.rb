class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:notice] = 'Comment created successfuly!'
      redirect_to user_post_path(current_user, @comment.post)
    else
      flash.now[:alert] = 'Failed to create Comment!!'
      render :new
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    comment.destroy!

    flash[:alert] = 'Comment Deleted'
    redirect_back fallback_location: [post]
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
