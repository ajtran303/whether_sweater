class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.build_facade(location: params[:location])
    render json: forecast, status: 200
  end
end
