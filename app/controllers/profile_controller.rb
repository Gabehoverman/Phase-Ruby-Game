class ProfileController < ApplicationController

	before_action :confirm_logged_in

def verify
	flash.now["alert-warning"] = "Logging in again is required to modify a user profile."
end

def profile
if session[:type] == "instructor"
	@user = Instructor.find(session[:user_id])
else
	flash[:notice] = "Admin"
    @user = Admin.find(session[:user_id])
end 

end

def editprofile
  
if session[:loggedinagain] == "true"

	if session[:type] == "instructor"
		@instructor = Instructor.find(session[:user_id])
	
else
	flash[:notice] = "Admin"
  @instructor = Admin.find(session[:user_id])
end 

else 
    flash[:notice] = "Please login again to make changes"
    redirect_to(:controller => :profile, :action => :verify, :cpw => false)

end
# session[:loggedinagain] = "false"


end

def editpassword

    if session[:loggedinagain] == "true"

	if session[:type] == "instructor"
		@instructor = Instructor.find(session[:user_id])
		
else
	flash[:notice] = "Admin"
    @instructor = Admin.find(session[:user_id])
end 

else 
    flash[:notice] = "Please login again to make changes"
    redirect_to(:controller => :profile, :action => :verify, :cpw => true)

end

end


def change
  if session[:loggedinagain] == "true"
  if session[:type] == "instructor"

@unchangedinstructor = Instructor.find(session[:user_id])

@instructor = Instructor.find(session[:user_id])
@change_to = instructor_params
else
@unchangedinstructor = Admin.find(session[:user_id])

@instructor = Admin.find(session[:user_id])
@change_to = instructor_params
end


  if params[:commit] == "Cancel"
      flash[:notice] = "Canceled"
    redirect_to(:controller => :profile, :action => :profile)
  else
    @instructor.attributes = @change_to
    if @instructor.save
           

            if session[:type] == "instructor"
          if @unchangedinstructor.email != @instructor.email
            @instructor.email_confirmed = false
            @instructor.save
             @instructor.send_email_activate
           end
       # InstructorMailer.registration_confirmation(@instructor).deliver_now
          end

            # flash[:notice] = "hellloooo" + @unchangedinstructor.email + @instructor.email
      flash[:notice] = "Current email: " + @instructor.email + " Current username: " + @instructor.username  

      if @unchangedinstructor.username != @instructor.username
      flash[:success] = "Remember to log in with " + @instructor.username + " next time!"  
	  end

      session[:loggedinagain] = "false"
      redirect_to(:controller => :profile, :action => :profile)

     else

      if params[:cpw] == "false"
        flash[:failure] = "Username or email is not unique or invalid character" 
          redirect_to(:controller => :profile, :action => :editprofile, :cpw => params[:cpw])
        else
        flash[:failure] = "Passwords do not match" 
        redirect_to(:controller => :profile, :action => :editpassword,  :cpw => params[:cpw])
      end
      end
      # redirect_to(:controller => :profile, :action => :profile)

  end



    else 
    flash[:notice] = "Please login again to make changes"
    redirect_to(:controller => :profile, :action => :verify)

end

end




def create
if session[:loggedinagain] == "true"

if session[:type] == "instructor"
@instructor = Instructor.find(session[:user_id])
@notchanged = @instructor.username
@newusername = instructorprarams[:username]

@instructor.username = @newusername

	if @instructor.save
		flash[:notice] =  @newusername + " is your username! Remember this for your login!"
			redirect_to(:controller => :profile, :action => :editprofile)

	else
		
		flash[:failure] = "Username not changed! " + @notchanged + " is still your username. Someone could already be using this username or the name included a special character."
		redirect_to(:controller => :profile, :action => :editprofile)

	end

else session[:type] == "admin"
		flash[:notice] = "Admin"
		redirect_to(:controller => :profile, :action => :editprofile)

end

        else 
    flash[:notice] = "Please login again to make changes"
    redirect_to(:controller => :profile, :action => :verify)

end
session[:loggedinagain] = "false"


end



private

    def instructor_params
      params.require(:instructor).permit(:username, :email, :password, :password_confirmation)
    end
  
  def cpw
      params.permit(:cpw)
    end

end


