require 'rails_helper'

describe Car do
  it { should have_many(:reservations) }
  it { should have_many(:users).through(:reservations) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_presence_of :test_drive_fee }
  it { should validate_presence_of :model }
  it { should validate_presence_of :year }
end
