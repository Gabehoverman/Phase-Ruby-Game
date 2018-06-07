class InstructorsController < ApplicationController
before_action :confirm_logged_in

def listinstructors
  if session[:type] == "admin"
  @instructors = Instructor.all
else
  flash[:failure] = "Not Available for Instructor account"
    redirect_to(:controller => :menu, :action => :menu)

end 

end

def create
if session[:type] == "admin"
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]



if @password_confirmation == @password

  @instructor = Instructor.new(instructor_params)


if @instructor.save
    flash[:notice] =  @instructor.username + " created successfully."
                 @instructor.send_email_activate

        #InstructorMailer.registration_confirmation(@instructor).deliver_now
  redirect_to(:controller => :instructors, :action => :listinstructors)

else
  flash[:failure] = "Instructor not created. Passwords do not match or Instructor is not unique or Password is not long enough or Special character in username. "
  redirect_to(:controller => :instructors, :action => :listinstructors)
end

else

  flash[:failure] = "Passwords do not match!"
  redirect_to(:controller => :instructors, :action => :listinstructors)

end
else 
  flash[:notice] = "Function not available for Instructor!"
  redirect_to(:controller => :menu, :action => :menu)
end


end

# def update
#     # render :instructor
#   @unchangedinstructor = Instructor.find(params[:id])
#   @instructor = Instructor.find(params[:id])
#   @password = params[:password]
#   @password_confirmation = params[:password_confirmation]

#     if @password_confirmation == @password
#       @instructor.attributes = instructor_params




#       if @instructor.save

#           if @unchangedinstructor.email != @instructor.email
#             @instructor.emailconfirmed == false
#             @instructor.save
#           end

#             flash[:notice] = @unchangedinstructor.email + @instructor.email


#  redirect_to @instructor, notice: 'Instructor was successfully created.' 

      
#     end

  # else render :create, :failure => "Make sure the passwords match!"
  # end



  # end

def edit
   @instructor = Instructor.find(params[:id])
   @id = @instructor.id

end


def changepassword
   @instructor = Instructor.find(params[:id])
   @id = @instructor.id

end

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

  def index
    @instructors = Instructor.all
  end

#inactivate
def change

if session[:type] == "admin"
@unchangedinstructor = Instructor.find(params[:id])

@instructors = Instructor.all
@instructor = Instructor.find(params[:id])
@change_to = instructor_params


  if params[:commit] == "Cancel"
      flash[:notice] = "Canceled"
    redirect_to(:controller => :menu, :action => :menu)
  else
    @instructor.attributes = @change_to
    if @instructor.save

          if @unchangedinstructor.email != @instructor.email
            @instructor.email_confirmed = false
            @instructor.save
             @instructor.send_email_activate
       # InstructorMailer.registration_confirmation(@instructor).deliver_now
          end

            # flash[:notice] = "hellloooo" + @unchangedinstructor.email + @instructor.email
      flash[:notice] = @instructor.username + " was changed!"

      else
        flash[:failure] = "Not saved"
      end
      redirect_to(:controller => :instructors, :action => :listinstructors)
  end

else
  
 flash[:notice] = "Function not available for Instructor!"
  redirect_to(:controller => :menu, :action => :menu)
end

end

def inactivate

if session[:type] == "admin"
@instructor = Instructor.find(params[:id])
@change_to = params[:change_to]


  if params[:commit] == "Cancel"
      flash[:notice] = "Canceled"
    redirect_to(:controller => :instructors, :action => :listinstructors)
  else
    @instructor.active = @change_to
    if @instructor.save
      if @change_to == 'true'
        flash[:success] = @instructor.username + " was activated!"
        else
          flash[:failure] = @instructor.username + " was deactivated!"
      end

      else
        flash[:failure] = "Not saved"
      end
    redirect_to(:controller => :instructors, :action => :listinstructors)
  end

else
  
 flash[:notice] = "Function not available for Instructor!"
  redirect_to(:controller => :menu, :action => :menu)
end

end

def reset
@instructor = Instructor.find(params[:id])

@instructor.send_password_reset 
flash[:success] = @instructor.username + "'s password reset was sent to " + @instructor.email
  redirect_to(:controller => :instructors, :action => :listinstructors)

end

private
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:username, :email, :password, :password_confirmation)
    end



end




#   before_action :set_instructor, only: [:show, :edit, :update, :destroy]

#   # GET /instructors
#   # GET /instructors.json
#   def index
#     @instructors = Instructor.all
#   end

#   # GET /instructors/1
#   # GET /instructors/1.json
#   def show
#     @instructor = Instructor.find(params[:id])
#   end

#   # GET /instructors/new
#   def new
#     @instructor = Instructor.new
#   end

#   # GET /instructors/1/edit
#   def edit
#    @instructor = Instructor.find(params[:id])


#   # if params[:commit] == "Cancel"
#   #     flash[:notice] = "Canceled"
#   #   redirect_to(:controller => :instructors)
#   # else
#   #       @instructor = instructor_params

#   #   if @instructor.save
#   #       flash[:success] = @instructor.username + " was changed!"

#   #     else
#   #       flash[:failure] = "Not changed"
#   #     end
#   #     redirect_to(:controller => :instructors, :action => :edit)
#   # end
#   end

#   # POST /instructors
#   # POST /instructors.json
#   def create
#     @instructor = Instructor.new(instructor_params)
#     @password = params[:password]
#     @password_conformation = params[:password_conformation]

#     if @password == @password

#     respond_to do |format|
#       if @instructor.save
#         format.html { redirect_to @instructor, notice: 'Instructor was successfully created.' }
#         format.json { render :show, status: :created, location: @instructor }
#       else
#         format.html { render :new }
#         format.json { render json: @instructor.errors, status: :unprocessable_entity }
#       end
#     end

#   else render :create, :failure => "Make sure the passwords match!"
#   end
#   end

#   # PATCH/PUT /instructors/1
#   # PATCH/PUT /instructors/1.json
#   def update
#     # render :instructor

#   @instructor = Instructor.find(params[:id])
#   @password = params[:password]
#   @password_conformation = params[:password_conformation]

#     if @password == @password
#       @instructor = instructor_params

#     respond_to do |format|
#       if @instructor.save
#         format.html { redirect_to @instructor, notice: 'Instructor was successfully created.' }
#         format.json { render :show, status: :created, location: @instructor }
#       else
#         format.html { render :new }
#         format.json { render json: @instructor.errors, status: :unprocessable_entity }
#       end
#     end

#   else render :create, :failure => "Make sure the passwords match!"
#   end
#   end

#   # DELETE /instructors/1
#   # DELETE /instructors/1.json
#   def destroy
#     @instructor.destroy
#     respond_to do |format|
#       format.html { redirect_to instructors_url, notice: 'Instructor was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_instructor
#       @instructor = Instructor.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def instructor_params
#       params.require(:instructor).permit(:username, :email, :password, :password_conformation)
#     end

#     #  def id_params
#     #   params[:id]
#     # end


# end
