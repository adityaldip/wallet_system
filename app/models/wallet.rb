class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :target_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  def calculate_balance
    self.balance = source_transactions.sum(:amount) - target_transactions.sum(:amount)
  end
  
  after_save :update_balance

  private

  def update_balance
    calculate_balance
    save if balance_changed? # Save only if balance has changed
  end
end
