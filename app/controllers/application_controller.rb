# Our application controller, triggered in every action we do.
class ApplicationController < ActionController::Base
  # Always authenticate user before any action
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if:  :devise_controller?
  protected
    # This is used to permit sending name attribute in sign up form
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
