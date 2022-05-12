class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end
