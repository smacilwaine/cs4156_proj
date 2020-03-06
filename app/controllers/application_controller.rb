class ApplicationController < ActionController::Base
    #protect_from_forgery with: :exception

    #def greeting
    #    render html: "Hello World!"
    #end
    
    before_action :authorized
    helper_method :current_user
    helper_method :logged_in?
    helper_method :is_student?
    helper_method :is_instructor?
    
    def current_user
        User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil? 
    end

    def authorized
        redirect_to welcome_path unless logged_in?
    end

    def is_student?
        return current_user.role == "Student"
    end

    def is_instructor?
        return current_user.role == "Instructor"
    end

end
