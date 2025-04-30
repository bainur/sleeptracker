class AddIndexOnUserAndClockin < ActiveRecord::Migration[7.0]
  def change
    add_index :sleep_records, [:user_id, :clock_in_time]
  end
end
