class CircuitSerializer < ActiveModel::Serializer
  attributes :id, :phase, :position, :circuit_type
end
