class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, foreign_key: { to_table: :wallets }, null: true
      t.references :target_wallet, foreign_key: { to_table: :wallets }, null: true
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.integer :transaction_type, null: false

      t.timestamps
    end
    add_check_constraint :transactions, '((source_wallet_id IS NOT NULL AND target_wallet_id IS NULL) OR (source_wallet_id IS NULL AND target_wallet_id IS NOT NULL))', name: 'check_wallets'
  end
end
