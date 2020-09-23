class Api::V1::UsersController < ApplicationController
  def create
    user = User.new user_params

    if registration_successful?.call user
      render json: UserFacade.build_facade(user), status: 201
    else
      render json: {errors: user.errors.full_messages.uniq}, status: 400
    end
  end

  private

  def registration_successful?
    proc do |user|
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.save
    end
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
