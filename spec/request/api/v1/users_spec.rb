# spec/requests/api/v1/users_spec.rb
require 'rails_helper' 

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { User.create!(name: "Test User") }
  let(:another_user) { User.create!(name: "Another User") }

  describe "GET /api/v1/profile" do
    it "returns the user's profile" do
      # Log in the user by setting X-User-Id header
      get "/api/v1/profile", headers: { "X-User-Id" => user.id }

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)

      expect(body["status"]).to eq("ok")
      expect(body["data"]["id"]).to eq(user.id.to_s)
    end
  end

  describe "POST /api/v1/follow" do
    context "when following another user" do
        it "creates a follow" do
            post "/api/v1/follow", params: { follow: { followed_user_id: another_user.id } },
                 headers: { "X-User-Id" => user.id }

            expect(response).to have_http_status(:created)
            body = JSON.parse(response.body)
            # Check if the correct followed_user_id is returned
            expect(body["data"]["attributes"]["followed_user"]["id"]).to eq(another_user.id)
          end
    end

    context "when already following the user" do
      before do
        user.follows.create!(followed_user: another_user)
      end

      it "returns the existing follow" do
        post "/api/v1/follow", params: { follow: { followed_user_id: another_user.id } },
             headers: { "X-User-Id" => user.id }

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body["data"]["attributes"]["followed_user"]["id"]).to eq(another_user.id)
      end
    end
  end

  describe "DELETE /api/v1/unfollow" do
    context "when unfollowing a user" do
      before do
        user.follows.create!(followed_user: another_user)
      end

      it "unfollows the user" do
        delete "/api/v1/unfollow", params: { follow: { followed_user_id: another_user.id } },
               headers: { "X-User-Id" => user.id }

        expect(response).to have_http_status(:no_content)
        expect(user.follows.find_by(followed_user: another_user)).to be_nil
      end
    end

    context "when not following the user" do
      it "does nothing and returns no content" do
        delete "/api/v1/unfollow", params: { follow: { followed_user_id: another_user.id } },
               headers: { "X-User-Id" => user.id }

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
