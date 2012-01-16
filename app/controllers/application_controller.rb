class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      controller_name == 'registrations' && action_name == 'edit' ? 'application' : 'sign' 
    else
      "application"
    end
  end
end
