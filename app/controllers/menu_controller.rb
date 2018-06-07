class MenuController < ApplicationController


before_action :confirm_logged_in

def menu
 if session[:type] == "admin"
	redirect_to(:controller => :menu, :action => :adminmenu)
end
end

def adminmenu
	 if session[:type] == "instructor"
	redirect_to(:controller => :menu, :action => :menu)
end
end

end
