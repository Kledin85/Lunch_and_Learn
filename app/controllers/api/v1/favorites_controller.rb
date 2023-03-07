class Api::V1::FavoritesController < ApplicationController

  def create
    favorite = Favorite.new(JSON.parse(request.body.read, symbolize_names: true))
    if favorite.save 
      render json: { "success": "Favorite added successfully" }
    else
      raise CreateError.new(details: favorite.errors.full_messages.to_sentence), status: :bad_request
    end
  end
end