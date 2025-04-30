class FollowedUser < ApplicationRecord
   belongs_to :user
   has_many :follows, foreign_key: :followed_user_id, class_name: 'Follow'
end
  