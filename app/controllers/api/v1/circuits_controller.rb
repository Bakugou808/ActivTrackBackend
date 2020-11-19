class Api::V1::CircuitsController < ApplicationController
  before_action :set_circuit, only: [:show, :update, :destroy]

  # GET /circuits
  def index
    @circuits = Circuit.all

    render json: @circuits
  end

  # GET /circuits/1
  def show
    render json: @circuit
  end

  # POST /circuits
  def create
    @circuit = Circuit.new(circuit_params)
    
    if @circuit.save
      render json: @circuit, status: :created
    else
      render json: @circuit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /circuits/1
  def update
    if @circuit.update(circuit_params)
      render json: @circuit
    else
      render json: @circuit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /circuits/1
  def destroy
    workouts = @circuit.workouts 
    workouts.each { |workout| workout.handleCircuitDeletion}
    if @circuit.destroy 
      render json: {message: "circuit destroyed"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circuit
      @circuit = Circuit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def circuit_params
      params.require(:circuit).permit(:phase, :sets, :position, :circuit_type)
    end
end
