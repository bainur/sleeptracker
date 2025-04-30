module Api
  module V1
    class UsersController < BaseController
      def profile
        render json: { status: :ok }.merge(UserSerializer.new(@current_user))
      end

      def follow
        @follow = @current_user.follows.build(follow_params)
        existing = @current_user.follows.find_by_followed_user_id(follow_params[:followed_user_id])

        if existing.nil? && @follow.save
          render json: FollowSerializer.new(@follow), status: :created
        else # this user has follow that user
          render json: FollowSerializer.new(existing), status: :ok
        end
      end

      def unfollow
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
