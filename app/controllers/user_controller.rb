class UserController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password, :role))
    if !@user.username || @user.username.length < 5 || !@user.email.length || !@user.password || @user.password.length < 5
      puts "invalid data!\n\n\n"
      redirect_to new_user_path
    else
      puts "valid! user created!\n\n\n"
      @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    end
  end

  def dashboard
  end
end
