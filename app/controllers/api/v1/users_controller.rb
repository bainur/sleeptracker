module Api
  module V1
    class UsersController < BaseController
      def profile
        cache_key = "user_profile/#{@current_user.id}"
      
        # Try to fetch cached data first
        cached_profile = Rails.cache.read(cache_key)
      
        if cached_profile
          # If cache exists, return cached data
          render json: cached_profile
        else
          # If not cached, fetch from the database and cache the result
          profile_data = { status: :ok }.merge(UserSerializer.new(@current_user))

          # Cache the profile data for 1 hour (you can adjust the expiration time as needed)
          Rails.cache.write(cache_key, profile_data, expires_in: 1.hour)
      
          render json: profile_data
        end
      end


      def follow
        if follow_params[:followed_user_id].to_i == @current_user.id
          return render json: { error: "You cannot follow yourself" }, status: :unprocessable_entity
        end

        @follow = @current_user.follows.build(follow_params)
        existing = @current_user.follows.find_by_followed_user_id(follow_params[:followed_user_id])

        if existing.nil? && @follow.save
          Rails.cache.delete("user_profile/#{@current_user.id}")
          render json: FollowSerializer.new(@follow), status: :created
        else # this user has follow that user
          render json: FollowSerializer.new(existing), status: :ok
        end
      end

      def unfollow
        Rails.cache.delete("user_profile/#{@current_user.id}")

        @follow = @current_user.follows.find_by_followed_user_id(follow_params[:followed_user_id])
        @follow&.destroy
      end

      private

      def set_follow
        @follow = @current_user.follows.find(params[:id])
      end

      def follow_params
        params.require(:follow).permit(:followed_user_id)
      end
    end
  end
end
