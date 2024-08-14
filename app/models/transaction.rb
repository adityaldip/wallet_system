class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :validate_wallets

  enum transaction_type: { credit: 0, debit: 1 }

  before_create :perform_transaction

  private

  def validate_wallets
    if credit? && source_wallet.present?
      errors.add(:source_wallet, 'should be nil for credits')
    elsif debit? && target_wallet.present?
      errors.add(:target_wallet, 'should be nil for debits')
    elsif credit? && target_wallet.nil?
      errors.add(:target_wallet, 'must be present for credits')
    elsif debit? && source_wallet.nil?
      errors.add(:source_wallet, 'must be present for debits')
    end
  end

  def perform_transaction
    ActiveRecord::Base.transaction do
      if credit?
        raise ActiveRecord::Rollback unless update_target_wallet_balance
      elsif debit?
        raise ActiveRecord::Rollback unless update_source_wallet_balance
      end
    end
  end

  def update_target_wallet_balance
    new_balance = target_wallet.balance + amount
    if target_wallet.update(balance: new_balance)
      true
    else
      Rails.logger.error("Failed to update target wallet balance: #{target_wallet.errors.full_messages}")
      false
    end
  end

  def update_source_wallet_balance
    new_balance = source_wallet.balance - amount
    if source_wallet.update(balance: new_balance)
      true
    else
      Rails.logger.error("Failed to update source wallet balance: #{source_wallet.errors.full_messages}")
      false
    end
  end
end
