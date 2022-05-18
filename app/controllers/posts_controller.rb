class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    if @post.save
      flash[:notice] = 'Post created successfully!'
      redirect_to user_posts_path(@user)
    else
      flash.now[:alert] = 'Failed to create Post!!'
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    flash[:alert] = 'Deleted post'
    redirect_to user_posts_path
  end

  def post_params
    params.permit(:title, :text)
  end
end
