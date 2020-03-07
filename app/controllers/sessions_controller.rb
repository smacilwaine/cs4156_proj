class SessionsController < ApplicationController
  
  skip_before_action :authorized, only: [:new, :create, :welcome]
  
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    #if @user && @user.authenticate(params[:password])
    #if @user
    #    puts @user.password_digest, "user.password_digest"
    #    puts params[:password], "params password"
    #    puts params[:password_digest], "params passowrd_digest"
    #end
    #STDOUT.puts "user is nil", @user == nil


    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to dashboard_path
    else
        redirect_to login_path
    end
  end

  def login
  end

  def welcome
  end
  
  def page_requires_login
  end  
    
  def logout
    reset_session
    redirect_to welcome_path
  end

end
