class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_filter :set_cache_buster
  add_flash_types :success, :info, :warning, :danger

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log-in before proceding"
      redirect_to(:controller => 'access', :action => 'login')
      return false
    else
      return true
    end
  end


def current_instructor
  @current_instructor ||= Instructor.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
end
end
