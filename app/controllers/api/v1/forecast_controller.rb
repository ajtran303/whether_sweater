class Api::V1::ForecastController < ApplicationController
  def index
    unless request_media_type_valid?
      error = Error.unsupported(request.path)
      render json: {errors: [error]}, status: 415
    end
  end

  private

  def request_media_type_valid?
    request.media_type == 'application/vnd.api+json'
  end
end
