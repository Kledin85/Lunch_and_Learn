class Api::V1::LearningResourcesController < ApplicationController
  def index
    learning_resource = YoutubeService.grab_video(params[:country])
    pictures = UnsplashService.grab_pictures(params[:country])
    render json: LearningResourcesSerializer.learning_resource(learning_resource[:items][0], pictures[:results], params[:country])
  end
end