class Api::V1::SessionsController < ApplicationController
  def create
    if user
      render json: UserFacade.build_facade(user), status: 200
    else
      render json: {errors: log_in_error_messages}, status: 401
    end
  end

  private
  def user
    @user ||= User.find_by(email: params[:email]).try(:authenticate, params[:password])
  end

  def email_empty?
    params[:email].empty?
  end

  def password_empty?
    params[:password].empty?
  end

  def user_found?
    !!User.find_by(email: params[:email])
  end

  def unregistered?
    !user_found? && !email_empty?
  end

  def wrong_password?
    user_found? && !password_empty?
  end

  def log_in_error_messages
    errors = []
    errors << "Email can't be blank" if email_empty?
    errors << "Password can't be blank" if password_empty?
    errors << 'No account registered with that email' if unregistered?
    errors << 'Wrong password' if wrong_password?
    errors
  end
end
