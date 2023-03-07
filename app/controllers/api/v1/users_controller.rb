class Api::V1::UsersController < ApplicationController

  def create
    user = User.new(JSON.parse(request.body.read, symbolize_names: true))
    user.update(api_key: User.generate_api_key)
    if user.save
      render json: UsersSerializer.serializer(user), status: 201
    else
      render json: { "error": "user did not save" }, status: 400
    end
  end
end