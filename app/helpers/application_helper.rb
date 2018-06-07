module ApplicationHelper

	 # def bootstrap_class_for flash_type
  #   case flash_type
  #     when "success"
  #       "alert-success"
  #     when "warning"
  #       "alert-warning"
  #     when "error"
  #       "alert-error"
  #     when "alert"
  #       "alert-block"
  #     when "notice"
  #       "alert-info"
  #     else
  #       flash_type.to_s
  #   end
  # end

    def alert_class_for(flash_type)
    {
      :success => 'alert-success',
      :error => 'alert-danger',
      :failure => 'alert-danger',
      :alert => 'alert-warning',
      :notice => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end
  
end
