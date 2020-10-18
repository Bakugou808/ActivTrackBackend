class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :workout_circuits
  # has_one :folder
  has_many :workout_circuits
  has_many :sessions
end
