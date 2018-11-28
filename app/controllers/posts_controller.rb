class PostsController < ApplicationController
  
  before_action :find_post, except: [:index, :new]


  def index
    @user = User.find_by(id:params[:user_id])
    @posts = @user.posts
  end

  def show
    if @post.nil? 
      flash[:danger] = "No post found"
      redirect_to new_user_post_path
    end
  end

  def new
    @user = User.find_by(id:params[:user_id])
    @post = @user.posts.build
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def find_post
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts
    @post = @posts.find_by(id:params[:id])
  end
end
