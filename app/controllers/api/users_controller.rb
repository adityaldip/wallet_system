module Api
    class UsersController < ActionController::API
      before_action :authenticate_request!
  
      def show
        wallet = @current_user.wallet
        render json: { user: @current_user, wallet: wallet }, status: :ok
      end
  
      private
  
      def authenticate_request!
        token_data = decoded_auth_token
        Rails.logger.info("Token data: #{token_data.inspect}")
        if token_data
          @current_user = User.find_by(id: token_data["user_id"])
          Rails.logger.info("User Data: #{@current_user}")
        end
        if @current_user.nil?
          Rails.logger.error("Failed authentication: #{@current_user.inspect}")
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      rescue => e
        Rails.logger.error("Authentication error: #{e.message}")
        render json: { error: 'Not Authorized' }, status: :unauthorized
      end
  
      def decoded_auth_token
        token = request.headers['Authorization'].to_s.split(' ').last
        Rails.logger.info("Received token: #{token}")
        return unless token.present?
  
        begin
          decoded_token = JWT.decode(token, Rails.application.secret_key_base).first
          Rails.logger.info("Decoded token: #{decoded_token}")
          decoded_token
        rescue JWT::DecodeError => e
          Rails.logger.error("Token decode error: #{e.message}")
          nil
        end
      end
    end
  end
  