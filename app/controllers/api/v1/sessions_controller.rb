class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    render json: UserFacade.build_facade(user), status: 200
  end
end
