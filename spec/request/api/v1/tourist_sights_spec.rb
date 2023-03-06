require 'rails_helper'

describe 'tourist_sights', type: :request do
  it 'can find tourist sights within a 20,000 meter radius of a capital' do
    json_response = File.read('spec/fixtures/france_capital.json')
    stub_request(:get, "https://restcountries.com/v3.1/name/France?fullText=true")
      .to_return(status: 200, body: json_response)
    json_response = File.read('spec/fixtures/paris.json')
    stub_request(:get, "https://api.geoapify.com/v2/places?categories=commercial&filter=circle:2.3483915,48.8534951,20000&bias=proximity:2.3483915,48.8534951&limit=20&apiKey=#{ENV['PLACES_KEy']}")
      .to_return(status: 200, body: json_response)

    get "/api/v1/tourist_sights?country=France"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    tourist_sights = JSON.parse(response.body, symbolize_names: true)
    expect(tourist_sights[:data]).to be_a(Array)
    expect(tourist_sights[:data][0]).to be_a(Hash)
    expect(tourist_sights[:data][0][:type]).to eq("tourist_sight")
    expect(tourist_sights[:data][0][:attributes]).to be_a(Hash)
    expect(tourist_sights[:data][0][:attributes]).to have_key(:name)
    expect(tourist_sights[:data][0][:attributes]).to have_key(:address)
    expect(tourist_sights[:data][0][:attributes]).to have_key(:place_id)
  end
end