class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?
  helper_method :current_user
  def after_sign_in_path_for(_resource)
    users_path
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :bio, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :bio, :password, :current_password)
    end
  end
end
