class PostsController < ApplicationController
  
  before_action :find_post, except: [:index, :new, :create]


  def index
    @user = User.find_by(id:params[:user_id])
    @posts = @user.posts
  end

  def show
    
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @post = @user.posts.build
  end

  def edit
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @post = @user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created!'
      redirect_to [@user, @post]
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to [@user, @post]
    else
      render 'edit'
    end


  end

  def destroy
    @post.destroy
    redirect_to [@user, @posts]
  end

  private

  def find_post
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts
    @post = @posts.find_by(id: params[:id])
    if @post.nil? 
      flash[:danger] = "No post found"
      redirect_to new_user_post_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
