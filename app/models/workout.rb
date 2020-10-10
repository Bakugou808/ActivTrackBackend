class Workout < ApplicationRecord
  belongs_to :folder
  has_many :workout_circuits
  has_many :circuits, through: :workout_circuits
end
