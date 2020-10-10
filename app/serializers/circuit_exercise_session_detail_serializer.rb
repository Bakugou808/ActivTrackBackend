class CircuitExerciseSessionDetailSerializer < ActiveModel::Serializer
  attributes :id, :stats
  has_one :session
  has_one :circuit_exercise
end
