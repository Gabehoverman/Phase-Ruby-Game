	class StudentmanagementController < ApplicationController


before_action :confirm_logged_in


def liststudents
	if session[:type] == "instructor"
	@students = Student.all.where(:instructor_id => session[:user_id])
else
	flash[:alert] = "Admin accounts are read only on this page!"
    @students = Student.all
end 

end

def create
if session[:type] == "instructor"
@student = Student.new(student_params)
@student.instructor_id = session[:user_id] 


if @student.save
  	flash[:notice] =  @student.student_id + " created successfully."
	redirect_to(:controller => :studentmanagement, :action => :liststudents)
else
	flash[:failure] = "Student not created. Student must have a unique ID and be of the format AAAA####."
	redirect_to(:controller => :studentmanagement, :action => :liststudents)
end

else 
	flash[:notice] = "Function not available for Admin!"
	redirect_to(:controller => :studentmanagement, :action => :liststudents)
end

end


def inactivate

if session[:type] == "instructor"
@students = Student.all.where(:instructor_id => session[:user_id])
@student = @students.find(params[:id])
@change_to = params[:change_to]


	if params[:commit] == "Cancel"
		  flash[:notice] = "Canceled"
		redirect_to(:controller => :studentmanagement, :action => :liststudents)
	else
		@student.active = @change_to
		if @student.save
			if @change_to == 'true'
				flash[:notice] = @student.student_id + " was enrolled!"
				else
					flash[:failure] = @student.student_id + " was unenrolled!"
			end

			else
				flash[:failure] = "Not saved"
			end
			redirect_to(:controller => :studentmanagement, :action => :liststudents)
	end

else
	
 flash[:notice] = "Function not available for Admin!"
 	redirect_to(:controller => :studentmanagement, :action => :liststudents)
end

end



private

def student_params
      params.require(:student).permit(:student_id, :active)
end


end