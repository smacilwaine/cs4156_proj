class UserController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def validate
    if @user.username.length < 5 || @user.password.length < 5 || URI::MailTo::EMAIL_REGEXP.match(@user.email) || @user.email.length < 1 || !@user.role
      return false
    else
      return true
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password, :role))
    if @user.validate
      redirect_to new_user_path
    else
      @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    end
  end

  def dashboard
  end
end
