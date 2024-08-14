class User < ApplicationRecord
  has_secure_password # Handles password encryption and authentication
  has_one :wallet, as: :walletable, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
end
