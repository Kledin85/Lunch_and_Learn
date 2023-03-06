class EdamamService

  def self.by_country(country)
    response = conn.get("?type=public&q=#{country}&app_id=0fc1b5ca&app_key=#{ENV['EDAMAM_KEY']}")
    parse_json(response)
  end

  def self.conn
    Faraday.new('https://api.edamam.com/api/recipes/v2')
  end 

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end