class CircuitExerciseSerializer < ActiveModel::Serializer
  attributes :id, :position, :attributes
  has_one :circuit
  has_one :exercise
end
