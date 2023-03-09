require 'swagger_helper'

RSpec.describe 'Sessions', type: :request do
  before do
    post '/users', params: {
      user: {
        name: 'andy',
        email: 'andy@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
  end
  path '/users/sign_in' do
    post('Sign In') do
      tags 'Sign In'
      description 'Sign In'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      let(:user) do
        {
          user: {
            email: 'andy@gmail.com',
            password: 'password'
          }
        }
      end

      response(201, 'successful') do
        examples 'application/json' =>
          { id: 1, name: 'Jay',
            token: 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.eLvmI-jvl7iBj2Kix4Kor20Nwur4F53KuB1NayRYJaQ' }
        run_test!
      end
    end
  end
end
