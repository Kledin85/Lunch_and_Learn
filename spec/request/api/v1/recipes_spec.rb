require 'rails_helper'

describe 'recipes', type: :request do
  it 'describes the index search by country' do
    country = "thailand"
    get "/api/v1/recipes?country=#{country}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    recipes = JSON.parse(response.body, symbolize_names: true)
    expect(recipes[:data]).to be_a(Array)
    recipes[:data].each do |recipe|
      # binding.pry
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
end