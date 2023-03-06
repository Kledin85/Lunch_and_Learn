require 'rails_helper'

describe 'tourist_sights', type: :request do
  it 'can find tourist sights within a 20,000 meter radius of a capital' do
    json_response = File.read('spec/fixtures/france_capital.json')
    stub_request(:get, "https://restcountries.com/v3.1/name/France?fullText=true")
      .to_return(status: 200, body: json_response)

    get "/api/v1/tourist_sights?country=France"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    
  end
end