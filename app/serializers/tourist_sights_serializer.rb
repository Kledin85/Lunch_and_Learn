class TouristSightsSerializer
  def self.tourist_sights(sights)
    {
      "data": sights[:features].map do |sight|
          {
              "id": nil,
              "type": "tourist_sight",
              "attributes": {
                  "name": sight[:properties][:name],
                  "address": sight[:properties][:address_line1],
                  "place_id": sight[:properties][:place_id]
              }
          }
      end
  }
  end
end