class CircuitExerciseSerializer < ActiveModel::Serializer
  attributes :id, :position, :ex_attributes
  has_one :circuit
  has_one :exercise
end
