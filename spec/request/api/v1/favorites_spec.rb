require 'rails_helper'

describe 'favorites', type: :request do
  before(:each) do
    @user1 = create(:user)

    @headers = {
      'CONTENT_TYPE': 'application/json',
      'ACCEPT': 'application/json'
    }
  end

  it 'can create favorite based on json favorite data' do
    payload = JSON.generate(
      {
        country: 'thailand',
        recipe_link: 'http://norecipes.com/recipe/chicken-paprikash/',
        recipe_title: 'Chicken Paprikash',
        api_key: @user1.api_key
      }
    )

    post "/api/v1/favorites", headers: @headers, params: payload
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    fav = JSON.parse(response.body, symbolize_names: true)
    expect(fav).to eq({:success=>"Favorite added successfully"}) 
  end

  it 'wont create favorite based on json favorite data' do
    payload = JSON.generate(
      {
        country: 'thailand',
        recipe_link: 'http://norecipes.com/recipe/chicken-paprikash/',
        recipe_title: 'Chicken Paprikash',
        api_key: '123sdfhb345bsasfp4ss'
      }
    )

    post "/api/v1/favorites", headers: @headers, params: payload
    expect(response.status).to eq(400)
    
    error = JSON.parse(response.body, symbolize_names: true)
    expect(error).to eq({ error: "Invalid api key"}) 
  end
  
  it 'can grab a users favorites' do
    payload = JSON.generate(
      {
        country: 'thailand',
        recipe_link: 'http://norecipes.com/recipe/chicken-paprikash/',
        recipe_title: 'Chicken Paprikash',
        api_key: @user1.api_key
      }
    )

    post "/api/v1/favorites", headers: @headers, params: payload

    get "/api/v1/favorites?api_key=#{@user1.api_key}"
    expect(response).to be_successful
    expect(response.status).to eq(200)
    favorites = JSON.parse(response.body, symbolize_names: true)
    expect(favorites[:data]).to be_a(Array)
    expect(favorites[:data][0]).to be_a(Hash)
    expect(favorites[:data][0]).to have_key(:id)
    expect(favorites[:data][0]).to have_key(:type)
    expect(favorites[:data][0]).to have_key(:attributes)
    expect(favorites[:data][0][:attributes]).to be_a(Hash)
    expect(favorites[:data][0][:attributes]).to have_key(:recipe_title)
    expect(favorites[:data][0][:attributes]).to have_key(:recipe_link)
    expect(favorites[:data][0][:attributes]).to have_key(:country)
    expect(favorites[:data][0][:attributes]).to have_key(:created_at)
  end
  
  it 'returns an error if invalid api key' do
    get "/api/v1/favorites?api_key=jh23b4ihfn34u3IBPNSjnwf"
    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)
    expect(error).to eq({ error: "Invalid api key"}) 
  end
end