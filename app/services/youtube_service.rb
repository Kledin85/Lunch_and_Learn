class YoutubeService

  def self.grab_video(country)
    response = conn.get("/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&maxResults=25&q=#{country}&key=AIzaSyBPnToGK58Pc5D311EpY4_Glur-3FsJaSI")
    parse_json(response)
  end

  def self.conn
    Faraday.new("https://youtube.googleapis.com")
  end 

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end