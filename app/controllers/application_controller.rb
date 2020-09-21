class ApplicationController < ActionController::API
  before_action :set_json_api_content_headers, :check_media_type

  def set_json_api_content_headers
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

  def request_media_type_valid?
    request.media_type == 'application/vnd.api+json'
  end

  def check_media_type
    unless request_media_type_valid?
      error = Error.unsupported(request.path)
      render json: {errors: [error]}, status: 415 and return
    end
  end
end
