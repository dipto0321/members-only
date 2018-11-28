class UsersController < ApplicationController
  before_action :find_user, only: %i[show edit update destroy]
  before_action :logged_in_user, only: [:edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to Members-Only #{@user.name}!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path
    else
      flash[:danger] = 'Not found!'
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def find_user
    @user = User.find_by(id:params[:id])
    if @user.nil?
      flash[:danger] = "User does not exist or has been deleted "
      redirect_to signup_path
    end
  end

  def logged_in_user
    if current_user.nil?
      flash[:danger] = "Please log in first"
      redirect_to signin_path
    end
  end

end
