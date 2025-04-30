# frozen_string_literal: true

module Api
  module V1
    # Base controller
    class BaseController < ApplicationController
      before_action :authenticate_user!
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      private

      def authenticate_user!
        return render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user
      end

      def current_user
        # Use this on HEADER using X-User-Id
        @current_user ||= User.find_by(id: request.headers['X-User-Id'])
      end

      def record_not_found
        render json: { error: 'Record not found' }, status: :not_found
      end
    end
  end
end
