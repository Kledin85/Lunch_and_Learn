class Api::V1::RecipesController < ApplicationController
  def index
    binding.pry
    if params[:country]
      recipes = EdamamService.by_country(params[:country])[:hits]
      render json: RecipesSerializer.recipe_serializer(recipes, params[:country])
    elsif params[:random]
      country = RestCountriesService.random_country.shuffle.first[:name][:common]
      recipes = EdamamService.by_country(country)[:hits]
      render json: RecipesSerializer.recipe_serializer(recipes, country)
    else 
      render json: {"data": []}
    end
  end
end