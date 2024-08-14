class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :symbol, null: false, unique: true
      t.string :company_name

      t.timestamps
    end
  end
end
