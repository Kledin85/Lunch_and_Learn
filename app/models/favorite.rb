class Favorite < ApplicationRecord
  validates_presence_of :api_key, :recipe_link, :recipe_title, :country
  belongs_to :user, foreign_key: 'api_key', primary_key: 'api_key'
end