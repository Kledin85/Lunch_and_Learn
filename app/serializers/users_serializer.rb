class UsersSerializer
  def self.serializer(data)
    {
      "data": {
        "type": "user",
        "id": data.id,
        "attributes": {
          "name": data.name,
          "email": data.email,
          "api_key": data.api_key
        }
      }
    }
  end
end