require 'rails_helper'

describe 'favorites', type: :request do
  it 'can grab a users favorites' do
    user = User.all.first
    get '/api/v1/favorites?api_key=G1uPCpnE4MSAXY5mgRQaIoZD0jy897Wq'
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
end