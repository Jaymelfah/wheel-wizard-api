class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { message: 'Sign up successful' }
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end
