class Car < ApplicationRecord
  include ImageUploader::Attachment.new(:image)

  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :name, :description, :price, :test_drive_fee, :model, :year, presence: true

  # allow mass-assignment of the image attribute
  attr_accessor :image_data

  attribute :image_data, :json, default: {}
end
