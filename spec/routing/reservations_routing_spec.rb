require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :routing do
  describe 'routing' do
    it { should route(:get, '/api/v1/reservations').to(action: :index) }
    it { should route(:post, '/api/v1/reservations').to(action: :create) }
    it { should route(:delete, '/api/v1/reservations/1').to(action: :destroy, id: 1) }
  end
end
