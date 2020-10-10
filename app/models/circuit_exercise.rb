class CircuitExercise < ApplicationRecord
  belongs_to :circuit
  belongs_to :exercise
  has_many :set_circuit_exercise_session_details
  serialize :attributes
end
