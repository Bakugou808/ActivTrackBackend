class CircuitExercise < ApplicationRecord
  belongs_to :circuit
  belongs_to :exercise
  has_many :circuit_exercise_session_details, dependent: :destroy
  #! BAD. RAILS DOIN TOO MUCH MESSING UP THE SQL QUERY DAA FUQQ. serialize :ex_attributes
end
