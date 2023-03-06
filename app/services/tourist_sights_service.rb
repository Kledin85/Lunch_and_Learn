class TouristSightsService

  def self.tourist_sights(lat, lng)
    response = conn.get("/v2/places?categories=tourism.sights&filter=circle:#{lng},#{lat},20000&bias=proximity:#{lng},#{lat}&limit=20&apiKey=#{ENV['PLACES_KEY']}")
    parse_json(response)
  end
  def self.conn
    Faraday.new("https://api.geoapify.com")
  end 

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end