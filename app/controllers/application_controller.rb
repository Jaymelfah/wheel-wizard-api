class ApplicationController < ActionController::API
  include Devise::JWT::Concerns::SetUserByToken

  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password current_password])
  end

  def current_user
    @current_user ||= User.find_by(id: payload['sub'])
  end
end
