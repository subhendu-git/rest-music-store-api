class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  before_filter :authenticate_user_from_token, except: [:token]
  
  def token
    authenticate_with_http_basic do |login, password|
      user = User.find_by(login: login)
      if user && user.password == password
        render json: {token: user.auth_token}, status: 200
      else
        render json: {error: 'Invalid credentials'}, status: 401
      end
    end
  end
  
  private
  
  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token)}
      render json: { error: 'Invalid token'}, status: 401
    end
  end
end
