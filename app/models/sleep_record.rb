# frozen_string_literal: true
class SleepRecord < ApplicationRecord
  belongs_to :user

  scope :ordered_by_created_time, -> { order(created_at: :asc) }
  scope :today, -> { where('date(created_at) = ?', Date.today )}

  before_save :update_duration

  def update_duration
    self.duration_in_sec = (clock_out_time - clock_in_time) / 1.seconds if clock_in_time && clock_out_time
  end
end
