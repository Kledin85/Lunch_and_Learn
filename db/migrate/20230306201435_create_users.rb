class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :api_key, null: false
      t.timestamps null: false
    end
    add_index :users, :api_key, unique: true
    add_index :users, :email, unique: true
  end
end
