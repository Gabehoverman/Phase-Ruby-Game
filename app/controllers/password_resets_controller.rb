class PasswordResetsController < ApplicationController


  layout 'common'

def confirm_email
    @instructor = Instructor.find_by_confirm_token(params[:id])
    if @instructor
      @instructor.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
  redirect_to(:controller => :menu, :action => :menu)
    else
      flash[:error] = "Sorry. User does not exist"
  redirect_to(:controller => :menu, :action => :menu)
    end
end

def create
  instructor = Instructor.find_by_email(params[:email])
  # admin = Admin.find_by_email(params[:email])
  if valid_email?(params[:email])
     instructor.send_password_reset if instructor
     # admin.send_password_reset if admin
     flash[:notice] = "Emails associated with an instructor account will recieve a password reset link."
      redirect_to(:controller => :access, :action => :login)

  else
    flash[:failure] = "Not an email address!"
    render(:new)
  end

end

def edit
  @instructor = Instructor.find_by_password_reset_token!(params[:id])
end

def update
  @instructor = Instructor.find_by_password_reset_token!(params[:id])
  
  if @instructor.password_reset_sent_at < 2.hours.ago
    redirect_to new_password_reset_path, :alert => "Password reset has expired."
  elsif @instructor.update_attributes(params.require(:instructor).permit(:password, :password_confirmation))
    redirect_to root_url, :notice => "Password has been reset!"
  else
     render :edit, :notice => "Make sure the passwords match!"
  end
end

def confirm
  @instructor = Instructor.find_by_confirm_token!(params[:id])
  @instructor.email_confirmed = true

   if @instructor.save!
    flash[:success] = @instructor.username + " thank you for confirming!"
  end
  redirect_to root_url


end

# private
#   def valid_email?(email)
#     VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
#     email.present? &&
#      (email =~ VALID_EMAIL_REGEX)
#   end
# end

private
  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? &&
     (email =~ valid)
  end
end

