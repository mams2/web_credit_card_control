class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :login, null: false
      t.string :name, null: false
      t.boolean :admin, default: false

      t.index :login, unique: true
      t.timestamps
    end
  end
end
