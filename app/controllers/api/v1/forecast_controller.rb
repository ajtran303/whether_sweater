class Api::V1::ForecastController < ApplicationController
  def index
    if request_media_type_valid?
      forecast = ForecastFacade.new(location: params[:location])
      render json: ForecastSerializer.to_json_api(forecast), status: 200
    else
      error = Error.unsupported(request.path)
      render json: {errors: [error]}, status: 415
    end
  end

  private

  def request_media_type_valid?
    request.media_type == 'application/vnd.api+json'
  end
end
