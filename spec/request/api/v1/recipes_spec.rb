require 'rails_helper'

describe 'recipes', type: :request do
  it 'describes the index search by country' do
    json_response = File.read('spec/fixtures/thailand_edamam.json')
    stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&q=thailand&app_id=0fc1b5ca&app_key=#{ENV['EDAMAM_KEY']}")
      .to_return(status: 200, body: json_response)
    country = "thailand"
    get "/api/v1/recipes?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    recipes = JSON.parse(response.body, symbolize_names: true)
    expect(recipes[:data]).to be_a(Array)
    recipes[:data].each do |recipe|
      expect(recipe).to be_a(Hash)
      expect(recipe[:id]).to eq(nil)
      expect(recipe[:type]).to eq("recipe")
      expect(recipe[:attributes]).to be_a(Hash)
      expect(recipe[:attributes]).to have_key(:title)
      expect(recipe[:attributes]).to have_key(:url)
      expect(recipe[:attributes]).to have_key(:country)
      expect(recipe[:attributes]).to have_key(:image)
    end
  end

  it 'describes the index search by random country' do
    json_response = File.read('spec/fixtures/all_countries.json')
    stub_request(:get, "https://restcountries.com/v3.1/all")
      .to_return(status: 200, body: json_response)
    get "/api/v1/recipes?random"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    recipes = JSON.parse(response.body, symbolize_names: true)
    expect(recipes[:data]).to be_a(Array)
    recipes[:data].each do |recipe|
      expect(recipe).to be_a(Hash)
      expect(recipe[:id]).to eq(nil)
      expect(recipe[:type]).to eq("recipe")
      expect(recipe[:attributes]).to be_a(Hash)
      expect(recipe[:attributes]).to have_key(:title)
      expect(recipe[:attributes]).to have_key(:url)
      expect(recipe[:attributes]).to have_key(:country)
      expect(recipe[:attributes]).to have_key(:image)
    end
  end

  it 'returns an empty data array if the string is empty' do
    get "/api/v1/recipes"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    resource = JSON.parse(response.body, symbolize_names: true)
    expect(resource[:data]).to eq([])
  end
end