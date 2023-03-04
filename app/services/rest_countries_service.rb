class RestCountriesService

  def self.random_country
    response = conn.get("/v3.1/all")
    parse_json(response)
  end
  def self.conn
    Faraday.new("https://restcountries.com")
  end 

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end