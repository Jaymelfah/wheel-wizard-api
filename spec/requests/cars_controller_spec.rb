require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :request do
  describe 'GET #index' do
    before { get '/api/v1/cars' }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all cars as JSON with image_url included' do
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(Car.count)
    end
  end

  describe 'GET #show' do
    before do
      @car = Car.new(name: 'Bugatti', description: 'Speed and Luxury infused', price: 10_000.0, test_drive_fee: 100.0,
                     model: 'Veyron', year: '2016-02-02')
      @car.image.attach(io: File.open(Rails.root.join('public', 'images', 'bugatti.png')), filename: 'bugatti.png')
      @car.save
    end

    it 'returns HTTP status 200' do
      get "/api/v1/cars/#{@car.id}"
      expect(response).to have_http_status(200)
    end
  end
end
