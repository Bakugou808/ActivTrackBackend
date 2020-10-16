class Workout < ApplicationRecord
  belongs_to :folder, required: true
  has_many :sessions, dependent: :destroy
  has_many :workout_circuits, dependent: :destroy
  has_many :circuits, through: :workout_circuits


  def formatted_workout
    
    warmup = self.warmup 
    body = self.body 
    cool_down = self.cool_down

    workout = {warmup: warmup, body: body, cool_down: cool_down}
    # byebug
    workout
  end

  def warmup
    ::Workouts::Circuits.new(self.id).find_by_phase('Warm Up')
  end

  def body
    ::Workouts::Circuits.new(self.id).find_by_phase('Body')
  end

  def cool_down
    ::Workouts::Circuits.new(self.id).find_by_phase('Cool Down')
  end




end
