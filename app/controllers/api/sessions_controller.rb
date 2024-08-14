module Api
  class SessionsController < ActionController::API
    # skip_before_action :verify_authenticity_token, only: [:create, :destroy]

    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        token = generate_token(user.id)
        render json: { message: 'Logged in!', token: token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end

    def destroy
      render json: { message: 'Signed out successfully' }, status: :ok
    end

    private

    def generate_token(user_id)
      JWT.encode({ user_id: user_id }, Rails.application.secret_key_base)
    end
  end
end
