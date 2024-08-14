# app/controllers/api/stocks_controller.rb
module Api
    class StocksController < ApplicationController
        before_action :authenticate_request!

      def index
        @stocks = Stock.includes(:wallet).all
        render json: @stocks, include: :wallet
      end
    end
  end
  