# app/controllers/api/teams_controller.rb
module Api
    class TeamsController < ApplicationController
        before_action :authenticate_request!

      def index
        @teams = Team.includes(:wallet).all
        render json: @teams, include: :wallet
      end
    end
  end
  