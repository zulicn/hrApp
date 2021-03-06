class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :restrict_access
  before_filter :set_current_user

  def restrict_access
    return redirect_to new_session_path if current_user.nil?
  end

  def set_current_user
    @current_user = current_user
  end
end
