class Api::V1::ClimbingRoutesController < ApplicationController
  def index
    climb_routes = ClimbingRoutesFacade.build_facade(location: params[:location])
    render json: ClimbingRoutesSerializer.to_json_api(climb_routes), status: 200
  end
end
