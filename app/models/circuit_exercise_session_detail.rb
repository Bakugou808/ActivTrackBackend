class CircuitExerciseSessionDetail < ApplicationRecord
  belongs_to :session
  belongs_to :circuit_exercise, optional :true
  # serialize :stats
end
