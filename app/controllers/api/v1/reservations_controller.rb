class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations.includes(:user)
    render json: @reservations, status: :ok
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    if @reservation.save
      render json: @reservation
    else
      render json: { error: 'Oops!, something went wrong' }, status: :bad_request
    end
  end

  def destroy
    unless @current_user == Reservation.find(params[:id]).user
      return render json: { error: 'You do not have permission' }, status: :unauthorized
    end

    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      render json: { message: 'Reservation deleted successfully' }
    else
      render json: { error: 'Oops, something went wrong' }, status: :bad_request
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:reservation_date, :duration, :city, :car_id)
  end
end
