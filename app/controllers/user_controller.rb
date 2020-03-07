class UserController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def validate()
    # things to prevent:
    # someone already signed up with that username
    # or with that email


  def create
    @user = User.create(params.require(:user).permit(:username, :email, :password, :role))

    # validate()

    session[:user_id] = @user.id
    redirect_to dashboard_path
  end

  def dashboard
  end
end
