require 'rails_helper'

describe Reservation do
  it { should belong_to(:user) }
  it { should belong_to(:car) }
  it { should validate_presence_of :car_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :reservation_date }
  it { should validate_presence_of :duration }
  it { should validate_presence_of :city }
end
