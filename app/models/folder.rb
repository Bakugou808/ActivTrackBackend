class Folder < ApplicationRecord
  belongs_to :user, required: true
  has_many :workouts, dependent: :destroy
  has_many :workout_circuits, through: :workouts
end
