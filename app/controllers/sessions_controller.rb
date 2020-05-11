class SessionsController < ApplicationController
  
  skip_before_action :authorized, only: [:new, :create, :index]
  
  def index
  end

  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "User logged in successfully."
      redirect_to user_index_path
    else
      flash[:error] = "User could not login successfully."
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = "User logged out successfully."
    redirect_to root_path
  end

end
