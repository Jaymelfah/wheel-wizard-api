require 'swagger_helper'

RSpec.describe 'api/v1/cars', type: :request do
  path '/api/v1/cars' do
    get('List all cars') do
      tags 'Cars'
      description 'List of cars'
      produces 'application/json'
      response '200', 'successful' do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            model: { type: :string },
            year: { type: :string, format: 'date' },
            description: { type: :string },
            test_drive_fee: { type: :number, format: 'float' },
            price: { type: :number, format: 'float' }
          },
          required: %w[id name model year description test_drive_fee price]
        }
        examples 'application/json' => [
          { id: 1, name: 'Car 1', model: 'Model A', year: '2020-02-02', description: 'luxury', test_drive_fee: 55,
            price: 5000 },
          { id: 2, name: 'Car 2', model: 'Model B', year: '2020-02-02', description: 'luxury', test_drive_fee: 55,
            price: 8000 },
          { id: 3, name: 'Car 3', model: 'Model C', year: '2020-02-02', description: 'luxury', test_drive_fee: 55,
            price: 3000 }
        ]
        run_test!
      end
    end

    post('Create or Add a Car') do
      tags 'Cars'
      description 'Create a Car'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          price: { type: :number },
          test_drive_fee: { type: :number },
          model: { type: :string },
          year: { type: :integer }
        },
        required: %w[name description price model year]
      }

      let(:car) do
        {
          name: 'Car 1',
          model: 'Model A',
          year: '2020-02-02',
          description: 'luxury',
          test_drive_fee: 55,
          price: 5000
        }
      end

      response(201, 'successful') do
        examples 'application/json' => [
          { id: 1, name: 'Car 1', model: 'Model A', year: '2020-02-02', description: 'luxury', test_drive_fee: 55,
            price: 5000 }
        ]
        run_test!
      end
    end
  end

  path '/api/v1/cars/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Show a specific Car details') do
      tags 'Cars'
      description 'Display a particular car with id'
      produces 'application/json'

      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          name: { type: :string },
          model: { type: :string },
          year: { type: :string, format: 'date' },
          description: { type: :string },
          test_drive_fee: { type: :number, format: 'float' },
          price: { type: :number, format: 'float' }
        },
        required: %w[id name model year description test_drive_fee price]
      }
      response '200', 'successful' do
        let(:id) { 1 } # Define id parameter in an example group
        examples 'application/json' => [
          { id: 1, name: 'Car 1', model: 'Model A', year: '2020-02-02', description: 'luxury', test_drive_fee: 55,
            price: 5000 }
        ]
        run_test!
      end
    end

    delete('Delete A specific Car') do
      tags 'Cars'
      description 'Delete a Car with a particular id'
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 message: { type: :string }
               }
        examples 'application/json' => {
          id: 1,
          message: 'Car was successfully deleted'
        }

        it 'returns the id of the deleted car' do
          expect(JSON.parse(response.body)['id']).to eq(1)
        end

        let(:id) { 1 }

        run_test!
      end
    end
  end
end
