# frozen_string_literal: true
# app/controllers/api/v1/sleep_records_controller.rb
module Api
  module V1
    # Sleep Records controller
    class SleepRecordsController < BaseController
      def clock_in
        sleep_record = @current_user.check_in(Time.current)

        render json: { status: :ok , message: 'Clock In Created' }
          .merge(SleepRecordSerializer.new(sleep_record))
      end

      def clock_out
        sleep_record = @current_user.check_out(Time.current)

        render json: { status: :ok , message: 'Clock Out Created / Updated' }
          .merge(SleepRecordSerializer.new(sleep_record))
      end

      def index
        # Paginate the sleep records
        sleep_records = @current_user.sleep_records
                                     .order(created_at: :desc)
                                     .page(params[:page])
                                     .per(params[:per_page] || 20) # Default to 20 per page if no `per_page` param is provided
      
        render json: {
          status: :ok,
          records: SleepRecordSerializer.new(sleep_records),
          meta: {
            current_page: sleep_records.current_page,
            total_pages: sleep_records.total_pages,
            total_count: sleep_records.total_count
          }
        }
      end

      def friends_sleep_records
        sleep_records = @current_user.friends_sleep_records
                                     .includes(:user) # Eager load associated user to avoid N+1
                                     .order(created_at: :desc)
                                     .page(params[:page])
                                     .per(params[:per_page] || 20) # Default 20 per page
      
        render json: {
          status: :ok,
          message: 'Your Friends sleep records',
          records: SleepRecordSerializer.new(sleep_records),
          meta: {
            current_page: sleep_records.current_page,
            total_pages: sleep_records.total_pages,
            total_count: sleep_records.total_count
          }
        }
      end
    end
  end
end
