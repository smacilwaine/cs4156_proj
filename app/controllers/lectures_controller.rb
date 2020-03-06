class LecturesController < ApplicationController
  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.create(params.require(:lecture).permit(:student))
    session[:lecture_active] = true
    session[:lec_id] = @lecture.id
    redirect_to '/view/:lec_id' #needs to be changed. use randomly generated lec_id. go to teach first
  end

  def view
  end

  def join
  end
    
  def teach
  end

  def leave
  end

  def terminate
  end
end
