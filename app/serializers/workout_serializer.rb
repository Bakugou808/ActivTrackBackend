class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_one :folder
  has_many :workout_circuits
end
