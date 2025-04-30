class Api::V1::SleepRecordSerializer
    include JSONAPI::Serializer
    belongs_to :user 
    attributes :id, :clock_in_time, :clock_out_time, :duration_in_sec

    attribute :duration_in_minutes do |object|
        object&.duration_in_sec&.seconds&.in_minutes
    end
end