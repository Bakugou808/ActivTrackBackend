class WorkoutCircuitSerializer < ActiveModel::Serializer
  attributes :id
  has_one :workout
  has_one :circuit
end
