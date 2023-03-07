require 'rails_helper'

describe 'users', type: :request do

  before(:each) do
    @headers = {
      'CONTENT_TYPE': 'application/json',
      'ACCEPT': 'application/json'
    }
  end

  it 'can create a new user' do
    payload = JSON.generate(
      {
        name: "Athena Dao",
        email: "athenadao@bestgirlever.com"
      }
    ) 

    post '/api/v1/users', headers: @headers, params: payload
    user = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data][:type]).to eq("user")
    expect(user[:data][:id]).to be_a(Integer)
    expect(user[:data][:attributes]).to be_a(Hash)
    expect(user[:data][:attributes]).to have_key(:name)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes][:name]).to be_a(String)
    expect(user[:data][:attributes][:email]).to be_a(String)
    expect(user[:data][:attributes][:api_key]).to be_a(String)
  end
  
  it 'returns an error if user does not save' do 
    payload = JSON.generate(
      {
        name: "Athena Dao",
      }
    )
    
    post '/api/v1/users', headers: @headers, params: payload
    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)
    expect(error).to eq({ error: "user did not save" }) 
  end
end