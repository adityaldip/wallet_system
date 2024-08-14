class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :update]

  def show
    render json: @wallet
  end

  def update
    if @wallet.update(wallet_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:id])
  end

  def wallet_params
    params.require(:wallet).permit(:balance)
  end
end
