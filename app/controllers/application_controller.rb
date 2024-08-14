class ApplicationController < ActionController::API
  include ActionController::Cookies
  # protect_from_forgery with: :exception
  
  def authenticate_request!
    @current_user = User.find(decoded_auth_token['user_id']) if decoded_auth_token
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  rescue
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

  private

  def decoded_auth_token
    token = request.headers['Authorization'].to_s.split(' ').last
    return unless token.present?

    JWT.decode(token, Rails.application.secret_key_base).first
  end
end