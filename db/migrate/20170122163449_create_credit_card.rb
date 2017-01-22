class CreateCreditCard < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.date :payment_date, null: false
      t.string :last_four_digits, null: false
      t.string :name, null: false
      t.references :account, foreign_key: true
    end
  end
end
