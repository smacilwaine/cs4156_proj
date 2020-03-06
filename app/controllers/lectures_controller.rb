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
    redirect_to :action => "view", :lec_id => @lecture.lec_id #needs to be changed. use randomly generated lec_id. go to teach first
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

  private

  @@current_lec_id = 0
end
