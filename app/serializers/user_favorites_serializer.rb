class UserFavoritesSerializer
  def self.favorites(favorites)
    {
      "data": favorites.map do |fav|
        {
          "id": fav.id,
          "type": "favorite",
          "attributes": {
              "recipe_title": fav.recipe_title,
              "recipe_link": fav.recipe_link,
              "country": fav.country,
              "created_at": Time.now
          }
        }
      end
    }
  end
end