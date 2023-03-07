class CreateFavorite < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string "country"
      t.string "recipe_link"
      t.string "recipe_title"
      t.string "api_key"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
