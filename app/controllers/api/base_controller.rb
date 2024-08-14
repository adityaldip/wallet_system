module Api
  class BaseController < ActionController::API
    # CSRF protection not needed for API controllers
    # skip_before_action :verify_authenticity_token
   
    def authenticate_request!
      @current_user = User.find(decoded_auth_token[:user_id]) if decoded_auth_token
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
end
