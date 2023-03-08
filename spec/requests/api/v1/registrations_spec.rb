require 'swagger_helper'

RSpec.describe 'users/registrations', type: :request do
  path '/users' do
    post('Sign Up a new User') do
      tags 'Sign up'
      description 'Sign up a new user'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name email password password_confirmation]
      }
      let(:user) do
        {
          user: {
            name: 'Jes',
            email: 'jes@gmail.com',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      response(200, 'successful') do
        examples 'application/json' =>
          { message: 'Sign up successful' }
        run_test!
      end
    end
  end
end
