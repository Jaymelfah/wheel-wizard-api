class Car < ApplicationRecord
  has_one_attached :image

  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :name, :description, :price, :test_drive_fee, :model, :year, presence: true
end
