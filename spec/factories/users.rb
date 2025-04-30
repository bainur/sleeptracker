# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { 'password123' } 
    end
  end
  
  # spec/factories/sleep_records.rb
  FactoryBot.define do
    factory :sleep_record do
      user
      clock_in_time { Time.current - 8.hours }
      clock_out_time { Time.current }
      duration_in_sec { 8.hours.to_i }
    end
  end
  