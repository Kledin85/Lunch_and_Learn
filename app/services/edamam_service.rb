class EdamamService

  def self.by_country(country)
    response = conn.get("?type=public&q=#{country}&app_id=0fc1b5ca&app_key=424c8a53318a03a35c52a47886c7067d")
    parse_json(response)
  end

  def self.conn
    Faraday.new('https://api.edamam.com/api/recipes/v2')
  end 

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end