require 'rails_helper'

describe User do
  it { should have_many(:reservations) }
  it { should have_many(:cars) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
end
