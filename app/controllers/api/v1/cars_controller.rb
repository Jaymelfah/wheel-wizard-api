class Api::V1::CarsController < ApplicationController
  def index
    @cars = Car.with_attached_image.all
    render json: @cars.map { |car| car.as_json.merge(image_url: url_for(car.image)) }, status: :ok
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

  private

  def car_params
    params.require(:car).permit(:name, :description, :price, :test_drive_fee, :model, :year)
  end
end
