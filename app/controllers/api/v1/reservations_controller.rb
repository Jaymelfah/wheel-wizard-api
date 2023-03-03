class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations.includes(:user)
    render json: @reservations
  end
end
