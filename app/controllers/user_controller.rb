class UserController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = " User - \"#{@user.username}\" created successfully."
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:warning] = "User creation unsuccessful, invalid form data."
      redirect_to new_user_path
    end
  end

  def dashboard
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :role, :email, :email_confirmation, :password_confirmation)
  end
end
