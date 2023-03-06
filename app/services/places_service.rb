class PlacesService

  def self.tourist_sights()
    response = conn.get("/v2/places?categories=tourism.sights&filter=circle:-125.30195833125842,49.74964065,20000&bias=proximity:-125.30195833125842,49.74964065&limit=20&apiKey=#{ENV'PLACES_KEY'}
      ")
    parse_json(response)
  end
  def self.conn
    Faraday.new("https://api.geoapify.com")
  end 

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end