class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :reservations, dependent: :destroy
  has_many :cars, through: :reservations

  validates :name, :email, presence: true

  def admin?
    role == 'admin'
  end
end
