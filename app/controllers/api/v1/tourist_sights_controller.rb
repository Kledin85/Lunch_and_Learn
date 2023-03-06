class Api::V1::TouristSightsController < ApplicationController

  def index
    country = RestCountriesService.capital(params[:country])
    capital = country[:capital][0]
    lat = country[:capitalInfo][:latlng][0]
    lng = country[:capitalInfo][:latlng][1]
    sights = TouristSightsService.tourist_sights(lat,lng)
    render json: TouristSightsSerializer.tourist_sights(sights)
  end
end