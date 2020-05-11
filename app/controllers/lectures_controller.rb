require 'uri'
require 'net/http'
require 'openssl'
require 'json'

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
    

    ##creating a room ##
    url = URI("https://api.daily.co/v1/rooms")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["authorization"] = 'Bearer ' + api_key

    response = http.request(request)
    ##########
    result = JSON.parse(response.body)
    @lecture.chat_url = result["url"] 
    @lecture.save
    redirect_to :action => "view", :lec_id => @lecture.id
    return
  end

  def view
    current_lecture = Lecture.find_by(id: params[:lec_id])
    @chat_url = current_lecture.chat_url
  end

  def join
    @invited_lectures = []
    student_lectures = Lecture.where(student_id: current_user.id, active: true)
    student_lectures.each do |lec|
      instructor = User.find_by(id: lec.instructor_id)
      @invited_lectures.append({"lec_id" => lec.id, "instructor" => instructor.username, "created_at" => lec.created_at})
    end
    puts @invited_lectures
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
