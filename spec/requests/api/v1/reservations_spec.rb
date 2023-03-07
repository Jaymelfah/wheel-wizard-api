require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do
  path '/api/v1/reservations' do
    get('A List of Users Reservations') do
      tags 'Reservations'
      description 'List of Reservations'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Bearer token'
      let(:auth_token) { 'your-bearer-token-here' }
      response '200', 'successful' do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            reservation_date: { type: :date },
            user_id: { type: :integer },
            car_id: { type: :integer },
            duration: { type: :float },
            city: { type: :string }
          },
          required: %w[id duration reservation_date user_id car_id city]
        }
        examples 'application/json' => [
          { id: 1, user_id: 1, car_id: 2, reservation_date: '2020-02-02', duration: 7, city: 'New York' },
          { id: 2, user_id: 1, car_id: 7, reservation_date: '2020-01-12', duration: 15.2, city: 'New York' },
          { id: 3, user_id: 1, car_id: 5, reservation_date: '2020-03-09', duration: 8, city: 'New York' }
        ]
        run_test!
      end
    end

    post('Create or Add a Reservation') do
      description 'Creates a new reservation with the provided details'

      tags 'Reservations'

      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, type: :string, description: 'Bearer token'

      let(:auth_token) { 'your-bearer-token-here' }

      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          reservation_date: { type: :string, format: 'date' },
          user_id: { type: :integer },
          car_id: { type: :integer },
          duration: { type: :number, format: 'float' },
          city: { type: :string }
        },
        required: %w[id duration reservation_date user_id car_id city]
      }

      let(:reservation) do
        {
          id: 1,
          reservation_date: '2023-03-07',
          user_id: 2,
          car_id: 4,
          duration: 17,
          city: 'Johannesburg'
        }
      end

      response(200, 'successful', headers: {}) do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    # You'll want to customize the parameter types...

    delete('Delete a specific Reservation') do
      tags 'Reservations'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :integer, description: 'id of reservation'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Bearer token'
      let(:auth_token) { 'your-bearer-token-here' }

      response(200, 'successful') do
        examples 'application/json' => { message: 'Reservation deleted successfully' }
        run_test!
      end
    end
  end
end
