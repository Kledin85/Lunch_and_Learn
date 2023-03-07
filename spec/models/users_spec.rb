require 'rails_helper'

describe User, type: :model do
  describe 'has many favorites' do
    it { should have_many(:favorites) }
  end
end