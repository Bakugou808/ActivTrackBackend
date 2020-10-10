class SessionSerializer < ActiveModel::Serializer
  attributes :id, :count, :active_time, :rest_time, :total_time
  has_one :Workout
end
