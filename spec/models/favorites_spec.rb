require 'rails_helper'

describe Favorite, type: :model do
  describe 'belongs to a user' do
    it { should belong_to(:user) }
  end
end