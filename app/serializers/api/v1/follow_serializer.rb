
class Api::V1::FollowSerializer
    include JSONAPI::Serializer
    
    attribute :follower, :followed_user
end