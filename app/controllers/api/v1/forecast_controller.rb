class Api::V1::ForecastController < ApplicationController
  def index
    unless request_media_type_valid?
      error = Error.unsupported(request.path)
      render json: {errors: [error]}, status: 415
    end

    if request_media_type_valid?
      response = { data:
                   { type:'forecast',
                     id: nil,
                     attributes: {
                       location: nil,
                       current_weather: nil,
                       forecast: {
                         eight_hour: nil,
                         five_day: nil
                       }
                     }
                   }
                 }
      render json: response, status: 200

      # forecast = ForecastFacade.new(params[:location])
      # render json: ForecastSerializer.to_json_api(forecast), status: 200
    end
  end

  private

  def request_media_type_valid?
    request.media_type == 'application/vnd.api+json'
  end
end
