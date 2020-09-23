class Api::V1::AuthorizeController < ApplicationController
  before_action :authorize

  private

  def authorize
    require_api_key unless api_key_found?
  end

  def api_key_found?
    @api_key_is_found = !!(User.find_by api_key: params[:api_key])
  end

  def require_api_key
    if params[:api_key].empty?
      render json: {errors: ["API Key can't be blank"]}, status: 401
    else
      render json: {errors: ['API Key not found']}, status: 401
    end
  end
end
