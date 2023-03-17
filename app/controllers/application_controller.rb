require 'English'
require "#{Rails.root}/lib/json_web_token"

class ApplicationController < ActionController::API
  before_action :authenticate_user_if_token_present
  before_action :update_allowed_parameters, if: :devise_controller?

  private

  def authenticate_user_if_token_present
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token

    payload = JsonWebToken.decode(token)

    user_id = payload['sub']

    @current_user = User.find_by(id: user_id)

    render json: { error: 'Invalid or expired token' }, status: :unauthorized if @current_user.nil?
  rescue JWT::ExpiredSignature, JWT::DecodeError
    render json: { error: 'Invalid or expired token' }, status: :unauthorized
  end

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password current_password])
  end
end
