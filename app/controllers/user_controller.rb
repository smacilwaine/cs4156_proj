class UserController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User - \"#{@user.username}\" created successfully."
      session[:user_id] = @user.id
      redirect_to user_index_path
    else
      flash[:error] = ""
      @user.errors.messages.each_pair {
        |k, v|
        v.each {
          |v|
          flash[:error] << "#{k} : #{v}. "
        }
      }
      redirect_to new_user_path
    end
  end

  def index
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :role, :email, :email_confirmation)
  end
end
