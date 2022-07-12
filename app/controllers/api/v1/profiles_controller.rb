# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      def me
        render json: current_user
      end

      def index
        profiles = User.where.not(id: current_user.id)
        render json: profiles
      end
    end
  end
end
