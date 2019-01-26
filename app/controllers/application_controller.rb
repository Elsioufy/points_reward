class ApplicationController < ActionController::Base

  def after_sign_in_path_for(scope)
    user_path(scope)
  end

  def after_sign_out_path_for(scope)
    root_path
  end
end
