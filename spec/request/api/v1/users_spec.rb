require 'rails_helper'

describe 'users', type: :request do
  xit 'can create a new user' do
    post '/api/v1/users'

    expect(response).to be_successful
    expect(response.status).to eq(201)
  end
end