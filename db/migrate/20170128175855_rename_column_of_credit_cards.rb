class RenameColumnOfCreditCards < ActiveRecord::Migration[5.0]
  def change
    rename_column :credit_cards, :payment_date, :payment_day
  end
end
