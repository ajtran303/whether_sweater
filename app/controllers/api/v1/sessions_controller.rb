class Api::V1::SessionsController < ApplicationController
  def create
    if user
      render json: UserFacade.build_facade(user), status: 200
    else
      errors = LogInErrors.build_errors email: params[:email], password: params[:password]
      render json: errors, status: 401
    end
  end

  private

  def user
    @user ||= User.find_by(email: params[:email]).try(:authenticate, params[:password])
  end
end
