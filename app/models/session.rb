class Session < ApplicationRecord
  belongs_to :workout
  has_many :circuit_exercise_session_details, dependent: :destroy
end
