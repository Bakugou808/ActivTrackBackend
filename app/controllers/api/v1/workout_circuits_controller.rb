class Api::V1::WorkoutCircuitsController < ApplicationController
  before_action :set_workout_circuit, only: [:show, :update, :destroy]

  # GET /workout_circuits
  def index
    @workout_circuits = WorkoutCircuit.all

    render json: @workout_circuits
  end

  # GET /workout_circuits/1
  def show
    render json: @workout_circuit
  end

  # POST /workout_circuits
  def create
    @workout_circuit = WorkoutCircuit.new(workout_circuit_params)

    if @workout_circuit.save
      render json: @workout_circuit, status: :created
    else
      render json: @workout_circuit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workout_circuits/1
  def update
    if @workout_circuit.update(workout_circuit_params)
      render json: @workout_circuit
    else
      render json: @workout_circuit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workout_circuits/1
  def destroy
    @workout_circuit.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_circuit
      @workout_circuit = WorkoutCircuit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workout_circuit_params
      params.require(:workout_circuit).permit(:workout_id, :circuit_id)
    end
end
