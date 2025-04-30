# db/seeds.rb

# Create users
Follow.delete_all
SleepRecord.delete_all
User.delete_all


users = User.create([
    { name: 'John', id: 1},
    { name: 'Jane', id: 2 },
    { name: 'Bob', id: 3 },
    { name: 'Alice', id: 4 },
    { name: 'David', id: 5 },
    { name: 'Lisa', id: 6 },
    { name: 'Mike', id: 7 },
    { name: 'Sara', id: 8 },
    { name: 'Tom', id: 9 },
    { name: 'Emily', id: 10 }
  ])

  # Create sleep records for users
  users.each do |user|
    rand(1..5).times do
      clock_in_time = Faker::Time.between(from: 1.week.ago, to: Time.current, format: :default)
      wakeup =  (clock_in_time.to_datetime + 7.hours)
      clock_out_time = Faker::Time.between(from: clock_in_time, to: wakeup.to_s, format: :default)
      user.sleep_records.create(
        clock_in_time: clock_in_time,
        clock_out_time: clock_out_time
      )
    end
  end

  # Create follows between users
  users[0..3].each do |follower|
    users[4..9].each do |followed_user|
      Follow.create(follower: follower, followed_user: followed_user)
    end
  end
  