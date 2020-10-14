class Api::V1::CircuitExercisesController < ApplicationController
  before_action :set_circuit_exercise, only: [:show, :update, :destroy]

  # GET /circuit_exercises
  def index
    @circuit_exercises = CircuitExercise.all

    render json: @circuit_exercises
  end

  # GET /circuit_exercises/1
  def show
    render json: @circuit_exercise
  end

  # POST /circuit_exercises
  def create
    @circuit_exercise = CircuitExercise.new(circuit_exercise_params)

    if @circuit_exercise.save
      render json: @circuit_exercise, status: :created
    else
      render json: {error: @circuit_exercise.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /circuit_exercises/1
  def update
    if @circuit_exercise.update(circuit_exercise_params)
      render json: @circuit_exercise
    else
      render json: {error: @circuit_exercise.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /circuit_exercises/1
  def destroy
    @circuit_exercise.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circuit_exercise
      @circuit_exercise = CircuitExercise.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def circuit_exercise_params
      params.require(:circuit_exercise).permit(:circuit_id, :exercise_id, :position, ex_attributes: {})
    end
end
