class Api::V1::CarsController < ApplicationController
  def index
    @cars = Car.all
    render json: @cars, status: :ok
  end

  def show
    @car = Car.where(id: params[:id])
    render json: @car, status: :ok
  end

#   def create
#     @car = Car.new(car_params)

#     if @car.save
#       render json: @car, status: :created
#     else
#       render json: @car.errors, status: :unprocessable_entity
#     end
#   end

#   private

#   def car_params
#     params.require(:car).permit(:name, :description, :price, :test_drive_fee, :model, :year, :image_data)
#   end
end
