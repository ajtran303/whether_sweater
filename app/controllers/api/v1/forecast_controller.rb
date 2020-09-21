class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.new(location: params[:location])
    render json: ForecastSerializer.to_json_api(forecast), status: 200
  end
end
