require 'swagger_helper'
require 'jwt'

RSpec.describe 'api/v1/reservations', type: :request do
  path '/api/v1/reservations' do
    get('A List of Users Reservations') do
      tags 'Reservations'
      description 'List of Reservations'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Bearer token'

      let(:user) { FactoryBot.create(:user) }
      let(:auth_token) { JsonWebToken.encode({ sub: user.id }) }

      response '200', 'successful' do
        let(:Authorization) { auth_token }
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
      let(:user) { FactoryBot.create(:user) }
      let(:car) { FactoryBot.create(:car) }
      let(:auth_token) { JsonWebToken.encode({ sub: user.id }) }
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
        required: %w[id duration reservation_date car_id city]
      }

      response(200, 'successful') do
        let(:Authorization) { auth_token }
        let(:reservation) { FactoryBot.create(:reservation, user:, car:) }
        examples 'application/json' => [
          { id: 1, user_id: 1, car_id: 2, reservation_date: '2020-02-02', duration: 7, city: 'New York' }
        ]
        run_test!
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    delete('Delete a specific Reservation') do
      tags 'Reservations'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :integer, description: 'id of reservation'
      parameter name: 'Authorization', in: :header, type: :string, description: 'Bearer token'
      let(:user) { FactoryBot.create(:user) }
      let(:car) { FactoryBot.create(:car) }
      let(:auth_token) { JsonWebToken.encode({ sub: user.id }) }

      response(200, 'successful') do
        let(:Authorization) { auth_token }
        let(:id) { reservation.id }
        let(:reservation) { FactoryBot.create(:reservation, user:, car:) }

        before do
          allow(Reservation).to receive(:find).with(reservation.id.to_s).and_return(reservation)
        end

        examples 'application/json' => { message: 'Reservation deleted successfully' }

        run_test! do
          expect(Reservation.find_by(id: reservation.id)).to be_nil
        end
      end
    end
  end
end
