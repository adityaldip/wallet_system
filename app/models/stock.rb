class Stock < ApplicationRecord
  has_one :wallet, as: :walletable, dependent: :destroy

  validates :symbol, presence: true, uniqueness: true

  def balance
    wallet&.balance || 0
  end
end