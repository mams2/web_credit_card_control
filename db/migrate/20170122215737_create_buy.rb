class CreateBuy < ActiveRecord::Migration[5.0]
  def change
    create_table :buys do |t|
      t.date :purchase_date, null: false
      t.integer :current_payment, null: false
      t.integer :total_payment, null: false
      t.float :value, null: false
      t.string :description, null: false
      t.text :list_of_buyers, null: false
      t.boolean :payment_in_current_month, null: false, default: false
      t.references :credit_card, foreign_key: true
    end
  end
end
