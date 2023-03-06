class Api::V1::TouristSightsController < ApplicationController

  def index
    capital = RestCountriesService.capital(params[:country])
    
  end
end