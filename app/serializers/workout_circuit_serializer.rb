class WorkoutCircuitSerializer < ActiveModel::Serializer
  attributes :id, :circuit
  has_one :workout
  has_one :circuit
end
