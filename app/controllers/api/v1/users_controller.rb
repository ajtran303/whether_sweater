class Api::V1::UsersController < ApplicationController
  def create
    user = User.new user_params
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    if user.save
      render json: UserFacade.build_facade(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
