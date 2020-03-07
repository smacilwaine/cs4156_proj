class LecturesController < ApplicationController
  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.create(params.require(:lecture).permit(:student))
    @lecture.instructor = current_user
    @lecture.lec_id = @@current_lec_id
    @lecture.active = true
    @@current_lec_id+=1
    @lecture.save
    ####debugging_code#####
    #selected_lecture = Lecture.find_by(lec_id: @lecture.lec_id)
    #if selected_lecture == nil
    #    puts "selected lecture is nil"
    #else
    #    puts "selected lecture has id", selected_lecture.lec_id
    #end
    ######################
    redirect_to :action => "view", :lec_id => @lecture.lec_id #needs to be changed. use randomly generated lec_id. go to teach first
  end

  def view
  end

  def join
  end

  def validate_join
    lec_id = params[:lecture][:lec_id]
    selected_lecture = Lecture.find_by(lec_id: lec_id)
    
    if (selected_lecture == nil) or !(selected_lecture.active) or (selected_lecture.student != current_user.username)
        redirect_to no_access_path
    else    
        redirect_to :action => "view", :lec_id => lec_id  
    end
  end
    
  def teach
  end

  def leave
  end

  def terminate
    lec_id = params[:lec_id]
    selected_lecture = Lecture.find_by(lec_id: lec_id)
    #puts "lec_id", lec_id
    #if selected_lecture == nil
    #    "selected_lecture is nil"
    #end
    selected_lecture.active = false
    selected_lecture.save
    redirect_to dashboard_path
  end

  def no_access
  end

  private

  @@current_lec_id = 0
end
