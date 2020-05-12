class SheetsController < ApplicationController
  def index
  end

  def new
  	@sheet = Sheet.new
  end

  def create
  	old_record = Sheet.find_by(name: params[:sheet][:name])
  	if old_record == nil
	  	@sheet = Sheet.new(params.require(:sheet).permit(:name, :attachment))

	  	if @sheet.save
	  		flash[:notice] = "#{@sheet.name} has been uploaded."
	  	else 
	  		flash[:warning] = "Unable to upload file."
	  	end
	  	redirect_to new_lecture_path :sheet_id => @sheet.id
	else
		flash[:warning] = "File name already exists. Choose another."
  		redirect_to new_sheet_path
  		return
  	end

  end

  def destroy
  end
end
