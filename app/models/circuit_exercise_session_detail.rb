class CircuitExerciseSessionDetail < ApplicationRecord
  belongs_to :session
  belongs_to :circuit_exercise
  serialize :stats
end
