class LearningResourcesSerializer
  def self.learning_resource(resource, pictures, country)
    {
        "data": {
            "id": nil,
            "type": "learning_resource",
            "attributes": {
                "country": country,
                "video": {
                    "title": resource[:snippet][:title],
                    "youtube_video_id": resource[:id][:videoId]
                },
                "images": pictures.map do |picture|
                    {
                      "alt_tag": picture[:alt_description],
                      "url": picture[:urls][:raw]
                    }
                end
                
          }
      }
  }
  end
end