require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe 'POST #create' do
    context 'when user is authenticated and params are valid' do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { JsonWebToken.encode({ sub: user.id }) }
      let(:car) { FactoryBot.create(:car) }
      let(:reservation_params) { { reservation_date: Time.now, duration: 2, city: 'New York', car_id: car.id } }

      before do
        request.headers['Authorization'] = "Bearer #{token}"
        post :create, params: { reservation: reservation_params }
      end

      it 'creates a new reservation for the user' do
        expect(user.reservations.count).to eq 1
      end

      it 'returns a reservation for a specific car' do
        expect(user.reservations.first.car_id).to eq car.id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
