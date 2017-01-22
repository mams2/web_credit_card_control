class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.references :account, foreign_key: true
    end
    add_index :users, :name
  end
end
