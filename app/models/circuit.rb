class Circuit < ApplicationRecord
    has_many :circuit_exercises, dependent: :destroy
    has_many :workout_circuits, dependent: :destroy
    has_many :workouts, through: :workout_circuits
    has_many :exercises, through: :circuit_exercises
end
