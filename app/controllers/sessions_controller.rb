class SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_for_database_authentication(email: params[:email])
    if user&.valid_password?(params[:password])
      token = JWT.encode({ sub: user.id }, Rails.application.credentials.secret_key_base)
      render json: { token: }, status: :created
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
