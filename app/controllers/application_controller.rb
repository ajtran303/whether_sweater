class ApplicationController < ActionController::API
  before_action :set_json_api_content_headers

  def set_json_api_content_headers
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

  def request_media_type_valid?
    request.media_type == 'application/vnd.api+json'
  end
end
