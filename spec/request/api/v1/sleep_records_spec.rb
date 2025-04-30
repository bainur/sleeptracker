# spec/requests/api/v1/sleep_records_spec.rb
require 'rails_helper' 

RSpec.describe "Api::V1::SleepRecords", type: :request do
  let(:user) { User.create!(name: "Test User") }

  describe "POST /api/v1/clock_in" do
    it "creates a sleep record (clock in)" do
      post "/api/v1/clock_in", headers: { "X-User-Id" => user.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Clock In Created")
      expect(SleepRecord.last.user).to eq(user)
    end
  end

  describe "POST /api/v1/clock_out" do
    before do
      user.sleep_records.create!(clock_in_time: Time.current)
    end

    it "updates the sleep record (clock out)" do
      post "/api/v1/clock_out", headers: { "X-User-Id" => user.id }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Clock Out Created / Updated")
      expect(SleepRecord.last.clock_out_time).not_to be_nil
    end
  end

  describe "GET /api/v1/sleep_records" do
    before do
      user.sleep_records.create!(clock_in_time: 2.hours.ago, clock_out_time: 1.hour.ago, duration_in_sec: 3600)
    end

    it "lists user sleep records" do
      get "/api/v1/sleep_records", headers: { "X-User-Id" => user.id }

      expect(response).to have_http_status(:ok)

      # Adjusting based on the JSONAPI::Serializer format
      body = JSON.parse(response.body)
      sleep_record = body["records"]["data"].first["attributes"]

      expect(sleep_record["duration_in_sec"]).to eq(3600)
    end
  end

  describe "GET /api/v1/friends_sleep_records" do
    let(:friend) { User.create!(name: "Friend User") }

    before do
      Follow.create!(follower: user, followed_user: friend)
      friend.sleep_records.create!(clock_in_time: 3.hours.ago, clock_out_time: 2.hours.ago, duration_in_sec: 3600)
    end

    it "lists friends' sleep records" do
      get "/api/v1/friends_sleep_records", headers: { "X-User-Id" => user.id }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["message"]).to eq("Your Friends sleep records")      
      expect(body["records"]["data"].first["attributes"]["duration_in_sec"]).to eq(3600)
    end
  end
end
