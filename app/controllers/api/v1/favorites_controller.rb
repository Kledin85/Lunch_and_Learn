class Api::V1::FavoritesController < ApplicationController

  def create
    favorite = Favorite.new(JSON.parse(request.body.read, symbolize_names: true))
    if favorite.save 
      render json: { "success": "Favorite added successfully" }
    else
      render json: { "error": "Invalid api key"}, status: 400
    end
  end
  
  def index
    if User.find_by(api_key: params[:api_key]) != nil
      user_favorites = User.find_by(api_key: params[:api_key]).favorites
      render json: UserFavoritesSerializer.favorites(user_favorites)
    else
      render json: { "error": "Invalid api key"}, status: 400
    end
  end

end