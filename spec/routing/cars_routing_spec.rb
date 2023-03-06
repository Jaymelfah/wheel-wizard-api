require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/cars').to route_to('api/v1/cars#index')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/cars/1').to route_to('api/v1/cars#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/cars').to route_to('api/v1/cars#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/cars/1').to route_to('api/v1/cars#destroy', id: '1')
    end
  end
end
