class UserController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :email, :password, :role))
    session[:user_id] = @user.id
    redirect_to '/dashboard'
  end

  def dashboard
  end
end
