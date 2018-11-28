class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(email: params[:sessions][:email])

    if @user && @user.authenticate(params[:sessions][:password])
      log_in(@user)
      flash[:success] = "#{@user.name} sign in"
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid email or Password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end
end
