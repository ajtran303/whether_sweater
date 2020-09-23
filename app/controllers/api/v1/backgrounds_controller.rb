class Api::V1::BackgroundsController < ApplicationController
  def index
    background = BackgroundsFacade.build_facade(location: params[:location])
    render json: background.to_json, status: 200
  end
end
