class LecturesController < ApplicationController
  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.new
    invited_student = User.find_by(username: params[:lecture][:student])
    if invited_student == nil
      flash[:warning] = "Invalid Student"
      redirect_to new_lecture_path
      return
    end
    @lecture.student_id = invited_student.id
    @lecture.instructor_id = current_user.id
    @lecture.active = true 
    @lecture.save
    redirect_to :action => "view", :lec_id => @lecture.id
  end

  def view
  end

  def join
  end

  def validate_join
    lec_id = params[:lecture][:lec_id]
    selected_lecture = Lecture.find_by(id: lec_id)
    
    if (selected_lecture == nil) 
      flash[:warning] = "Lecture does not exist"
      redirect_to join_path
    elsif !(selected_lecture.active) 
      flash[:warning] = "This lecture has ended"
      redirect_to join_path
    elsif (selected_lecture.student_id != current_user.id)
      flash[:warning] = "You do not have access to this lecture"
      redirect_to join_path
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
    selected_lecture = Lecture.find_by(id: lec_id)
    #puts "lec_id", lec_id
    #if selected_lecture == nil
    #    "selected_lecture is nil"
    #end
    selected_lecture.active = false
    selected_lecture.save!
    redirect_to user_index_path
  end

  def no_access
  end

end
