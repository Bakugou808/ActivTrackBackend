class Session < ApplicationRecord
  belongs_to :Workout
  has_many :circuit_exercise_session_details
end
