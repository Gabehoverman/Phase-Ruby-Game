class AccessController < ApplicationController

  layout 'common'

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
  	# display text links
  end

  def login
  	# login form
    if !session[:user_id].blank? && !session[:username].blank?
      redirect_to( :controller => 'menu', :action => 'menu' )
    end
  end

  def attempt_login
  	if params[:username].present? && params[:password].present?
  		if instructor = Instructor.where(:username => params[:username]).first
  			authorized_instructor = instructor.authenticate(params[:password])
      elsif admin = Admin.where(:username => params[:username]).first
        authorized_admin = admin.authenticate(params[:password])
      end
  	end

  	if authorized_instructor
      if authorized_instructor.active == true
  		session[:user_id] = authorized_instructor.id
  		session[:username] = authorized_instructor.username
      session[:type] = "instructor"
  		redirect_to(:controller => 'menu', :action => 'menu')
    else
            flash[:failure] = "Account is not available, please contact an Admin"
            redirect_to(:controller => 'access', :action => 'login')

    end

  	elsif authorized_admin
		  session[:user_id] = authorized_admin.id
      session[:username] = authorized_admin.username
      session[:type] = "admin"
      flash[:notice] = "Now logged in as an Admin"
      redirect_to(:controller => 'menu', :action => 'menu')
    
    else
      flash[:failure] = "Invalid username/password combination."
      redirect_to(:action => 'login')
  	end
  end

  def logout

    session[:user_id] = nil
    session[:username] = nil
  	flash[:notice] = "Logged out"
  	redirect_to(:action => 'login')
  end

   def profile
    # login form
    if !session[:user_id].blank? && !session[:username].blank?
      redirect_to( :controller => :profile, :action => :editprofile )
    end
  end

  def attempt_profile
    if params[:username].present? && params[:password].present?
      if instructor = Instructor.where(:username => params[:username]).first
        authorized_instructor = instructor.authenticate(params[:password])
      elsif admin = Admin.where(:username => params[:username]).first
        authorized_admin = admin.authenticate(params[:password])
      end
    end

    if authorized_instructor
      session[:user_id] = authorized_instructor.id
      session[:username] = authorized_instructor.username
      session[:type] = "instructor"
      session[:loggedinagain] = "true"
      # redirect_to(:controller => :menu, :action => :menu, :session => session[:loggedinagain])

       # flash[:success] = session[:loggedinagain]



    if authorized_instructor.active == true

    if params[:cpw] == "false"
      redirect_to(:controller => :profile, :action => :editprofile, :cpw => params[:cpw])
     else
      redirect_to( :controller => :profile, :action => :editpassword, :cpw => params[:cpw] )
     end

   else
        flash[:failure] = "Account is not available, please contact an Admin"
        redirect_to(:controller => 'access', :action => 'login')

    end

    elsif authorized_admin
      session[:user_id] = authorized_admin.id
      session[:username] = authorized_admin.username
      session[:type] = "admin"
      flash[:notice] = "Logged in as Admin."
      session[:loggedinagain] = "true"

    if params[:cpw] == "false"
      redirect_to(:controller => :profile, :action => :editprofile, :cpw => params[:cpw])
     else
      redirect_to( :controller => :profile, :action => :editpassword , :cpw => params[:cpw])
     end

    else
      flash[:failure] = "Invalid username/password combination."
      redirect_to(:controller => :profile, :action => :verify)
    end
  end




end
