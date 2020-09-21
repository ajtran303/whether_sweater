class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    if request_media_type_valid?
      climb_routes = ClimbingRoutesFacade.new(location: params[:location])
      render json: ClimbingRoutesSerializer.to_json_api(climb_routes), status: 200
    else
      error = Error.unsupported(request.path)
      render json: {errors: [error]}, status: 415
    end
  end
end
