class Circuit < ApplicationRecord
    has_many :circuit_exercises
    has_many :workout_circuits
    has_many :workouts, through: :workout_circuits
    has_many :exercises, through: :circuit_exercises
end
