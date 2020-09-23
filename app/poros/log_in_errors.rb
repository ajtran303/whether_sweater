class LogInErrors
  def self.build_errors(params)
    errors = new email: params[:email], password: params[:password]
    {errors: errors.log_in_error_messages}
  end

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
  end

  def log_in_error_messages
    errors = []
    errors << "Email can't be blank" if email_empty?
    errors << "Password can't be blank" if password_empty?
    errors << 'No account registered with that email' if unregistered?
    errors << 'Wrong password' if wrong_password?
    errors
  end

  private

  def email_empty?
    @email.empty?
  end

  def password_empty?
    @password.empty?
  end

  def user_found?
    !!User.find_by(email: @email)
  end

  def unregistered?
    !user_found? && !email_empty?
  end

  def wrong_password?
    user_found? && !password_empty?
  end
end
