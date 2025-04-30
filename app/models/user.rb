# frozen_string_literal: true
# Class User For generating check in/ check out

class User < ApplicationRecord
  has_many :sleep_records, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed_user

  def friends_sleep_records
    friend_ids = follows.pluck(:followed_user_id)
    sort_order = '(sleep_records.clock_out_time - sleep_records.clock_in_time) DESC'

    SleepRecord.where(user_id: friend_ids)
               .where('sleep_records.clock_in_time >= ?', 1.week.ago)
               .order(Arel.sql(sort_order))
  end

  def today_activities
    sleep_records.order('id desc').first
  end

  def check_in(time)
    sleep_record = sleep_records.last
    # today check in exist, just update it, if the clock out time has been filled
    if sleep_record.present? && sleep_record.clock_out_time.nil?
      sleep_record.update(clock_in_time: time)
    else # create new record for today
      sleep_record = sleep_records.create(clock_in_time: time)
    end

    sleep_record
  end

  def check_out(time)
    sleep_record = sleep_records.last
    # today check in exist, just update it

    sleep_record.update(clock_out_time: time) if sleep_record.present? && sleep_record.clock_out_time.nil?
    sleep_record
  end
end
