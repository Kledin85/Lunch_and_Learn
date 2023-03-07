class User < ApplicationRecord
  validates_presence_of :api_key, :email, :name
  validates_uniqueness_of :api_key, :email
  has_many :favorites, foreign_key: 'api_key', primary_key: 'api_key'

  def self.generate_api_key
  ('a'..'z').to_a.concat(('A'..'Z').to_a).concat(('0'..'9').to_a).shuffle[0,32].join
  end

end