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
        sleep_records = @current_user.sleep_records.order(created_at: :desc)

        render json: SleepRecordSerializer.new(sleep_records),  status: :ok
      end

      def friends_sleep_records
        sleep_records = @current_user.friends_sleep_records
        render json: { status: :ok , message: 'Your Friends sleep records' }
          .merge(SleepRecordSerializer.new(sleep_records))
      end
    end
  end
end
