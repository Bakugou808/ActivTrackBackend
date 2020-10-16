class CircuitSerializer < ActiveModel::Serializer
  attributes :id, :phase, :position, :sets, :circuit_type, :circuit_exercises 
  has_many :circuit_exercises 
end
