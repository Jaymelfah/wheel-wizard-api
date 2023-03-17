class Api::V1::CarsController < ApplicationController
  def index
    @cars = Car.with_attached_image.all
    render json: @cars.map { |car|
      image_url = car.image.attached? ? url_for(car.image) : nil
      car.as_json.merge(image_url:)
    }, status: :ok
  end

  def new
    @car = Car.new
  end

  def show
    @car = Car.with_attached_image.find(params[:id])
    render json: @car.as_json.merge(image_url: url_for(@car.image)), status: :ok
  end

  def create
    @car = Car.new(car_params)
    @car.image.attach(params[:car][:image]) if params[:car][:image].present?

    if @car.save
      render json: @car, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @car = Car.find(params[:id])
    if @car.destroy
      render json: { id: @car.id, message: 'Car was successfully deleted' }
    else
      render json: { error: 'Car could not be deleted' }, status: :bad_request
    end
  end

  private

  def car_params
    params.require(:car).permit(:name, :description, :price, :test_drive_fee, :model, :year)
  end
end
