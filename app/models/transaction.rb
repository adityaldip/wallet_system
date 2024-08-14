class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :validate_wallets

  enum transaction_type: { credit: 0, debit: 1 }

  after_create :perform_transaction

  private

  def validate_wallets
    if credit?
      errors.add(:source_wallet, 'should be nil for credits') if source_wallet.present?
      errors.add(:target_wallet, 'must be present for credits') if target_wallet.nil?
    elsif debit?
      errors.add(:target_wallet, 'should be nil for debits') if target_wallet.present?
      errors.add(:source_wallet, 'must be present for debits') if source_wallet.nil?
      if source_wallet && amount > source_wallet.balance
        errors.add(:amount, 'exceeds available balance')
      end
    end
  end

  def perform_transaction
    ActiveRecord::Base.transaction do
      if credit?
        update_target_wallet_balance
      elsif debit?
        update_source_wallet_balance
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Transaction failed: #{e.message}")
    errors.add(:base, 'Transaction could not be completed. Please try again.')
    throw(:abort) # Ensure the transaction does not commit
  end

  def update_target_wallet_balance
    target_wallet.with_lock do
      new_balance = target_wallet.balance + amount
      target_wallet.update!(balance: new_balance)
    end
  end

  def update_source_wallet_balance
    source_wallet.with_lock do
      new_balance = source_wallet.balance - amount
      source_wallet.update!(balance: new_balance)
    end
  end
end
