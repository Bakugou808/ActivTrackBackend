class Api::V1::CircuitExerciseSessionDetailsController < ApplicationController
  before_action :set_circuit_exercise_session_detail, only: [:show, :update, :destroy]

  # GET /circuit_exercise_session_details
  def index
    @circuit_exercise_session_details = CircuitExerciseSessionDetail.all

    render json: @circuit_exercise_session_details
  end

  # GET /circuit_exercise_session_details/1
  def show
    render json: @circuit_exercise_session_detail
  end

  # POST /circuit_exercise_session_details
  def create
    
    @circuit_exercise_session_detail = CircuitExerciseSessionDetail.new(circuit_exercise_session_detail_params)
    
    if @circuit_exercise_session_detail.save
      render json: @circuit_exercise_session_detail, status: :created
    else
      render json: @circuit_exercise_session_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /circuit_exercise_session_details/1
  def update
    if @circuit_exercise_session_detail.update(circuit_exercise_session_detail_params)
      render json: @circuit_exercise_session_detail
    else
      render json: @circuit_exercise_session_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /circuit_exercise_session_details/1
  def destroy
    @circuit_exercise_session_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circuit_exercise_session_detail
      @circuit_exercise_session_detail = CircuitExerciseSessionDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def circuit_exercise_session_detail_params
      params.require(:circuit_exercise_session_detail).permit(:session_id, :circuit_exercise_id, stats: {})
    end
end
