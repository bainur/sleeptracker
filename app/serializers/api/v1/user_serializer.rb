class Api::V1::UserSerializer
  include JSONAPI::Serializer

  attributes :name, :id
  attribute :followers do |object|
    object.followed_users
  end

  attribute :following do |object|
    object.follows
  end

  has_many :sleep_records
end