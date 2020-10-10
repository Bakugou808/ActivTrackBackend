class Folder < ApplicationRecord
  belongs_to :user
  has_many :workouts
  has_many :workout_circuits, through: :workouts
end
