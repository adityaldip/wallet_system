class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true, null: false
      t.decimal :balance, precision: 15, scale: 2, default: 0.00, null: false

      t.timestamps
    end
    add_index :wallets, [:walletable_id, :walletable_type], unique: true
  end
end
