class ChangeDataTypeForCreditCards < ActiveRecord::Migration[5.0]
  def change
    change_column(:credit_cards, :payment_date, :integer)
  end
end
