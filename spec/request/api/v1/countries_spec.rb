require 'rails_helper'

describe 'countries', type: :request do
  it 'describes the country show controller' do
    json_response = File.read('spec/fixtures/country_show_india.json')
    stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&maxResults=25&q=India&key=AIzaSyBPnToGK58Pc5D311EpY4_Glur-3FsJaSI")
      .to_return(status: 200, body: json_response)

    get "/api/v1/learning_resources?country=India"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    resource = JSON.parse(response.body, symbolize_names: true)
    expect(resource[:data][:id]).to eq(nil)
    expect(resource[:data][:type]).to eq("learning_resource")
    expect(resource[:data][:attributes]).to be_a(Hash)
    expect(resource[:data][:attributes]).to have_key(:country)
    expect(resource[:data][:attributes]).to have_key(:video)
    expect(resource[:data][:attributes]).to have_key(:images)
    expect(resource[:data][:attributes][:video]).to be_a(Hash)
    expect(resource[:data][:attributes][:video]).to have_key(:title)
    expect(resource[:data][:attributes][:video]).to have_key(:youtube_video_id)
    expect(resource[:data][:attributes][:images]).to be_a(Array)
    expect(resource[:data][:attributes][:images].length).to eq(10)
    expect(resource[:data][:attributes][:images][0]).to have_key(:alt_tag)
    expect(resource[:data][:attributes][:images][0]).to have_key(:url)
  end
end