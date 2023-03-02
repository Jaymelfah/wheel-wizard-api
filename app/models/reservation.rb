class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :car_id, :user_id, :reservation_date, :duration, presence: true
end
