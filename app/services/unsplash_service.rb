class UnsplashService

  def self.grab_pictures(country)
    response = conn.get("/search/photos?page=10&query=#{country}&client_id=_O_NP-B67HqSKoTd1ce1k0AmThswhOfLWrdMEOXcyRw")
    parse_json(response)
  end

  def self.conn
    Faraday.new("https://api.unsplash.com")
  end 

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end