class Api::V1::WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :formatWorkout, :update, :destroy]

  # GET /workouts
  def index
    @workouts = Workout.all

    render json: @workouts
  end

  # GET /workouts/1
  def show
    render json: @workout
  end
  
  # '/formatted_workout/:workout_id'
  def format_workout
    workout = Workout.find(params[:workout_id])
    formatted = workout.formatted_workout
    render json: formatted
  end

  # '/workouts_stats/:user_id'
  def all_workouts_with_stats 
    user = User.find(params[:user_id])
    workouts = user.workouts 
    data = Workout.grab_all_workouts_with_session_details(workouts)
    render json: {data: data}

  end

  # '/workouts_stats/:workout_id'
  def workouts_stats 
    workout = Workout.find(params[:workout_id].to_i)
    
    stats = nil
    if params[:num_of_sessions].to_i == 0
      stats = workout.grab_session_details_by_exercise(nil)
    else
      stats = workout.grab_session_details_by_exercise(params[:num_of_sessions].to_i) 
    end
    
    render json: {stats: stats}
  end

  # '/workouts_stats_by_date/:workout_id/:start_date/:end_date'
  def workouts_stats_by_date 
    workout = Workout.find(params[:workout_id].to_i)
    
    stats = workout.grab_session_details_by_date(params[:start_date], params[:end_date])
    byebug
    render json: {stats: stats}

  end

  # POST /workouts
  def create
    @workout = Workout.new(workout_params)

    if @workout.save
      render json: @workout, status: :created
    else
      render json: @workout.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workouts/1
  def update
    
    if @workout.update(workout_params)
      render json: @workout
    else
      render json: @workout.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workouts/1
  def destroy
    if @workout.destroy
      render json: params[:id]
    else 
      render json: {error: "There Was An Error. Attempt: Destroy Folder."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workout_params
      params.require(:workout).permit(:folder_id, :title, :description)
    end
end
