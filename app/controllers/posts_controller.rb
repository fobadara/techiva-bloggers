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

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)
    @post.save
    redirect_to user_posts_path(@user)
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
  end

  def post_params
    params.require(:user).permit(:title, :text)
  end
end
