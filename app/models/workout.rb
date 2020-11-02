class Workout < ApplicationRecord
  belongs_to :folder, required: true
  has_many :sessions, dependent: :destroy
  has_many :workout_circuits, dependent: :destroy
  has_many :circuits, through: :workout_circuits


  def self.grab_all_workouts_with_session_details(workouts)
    workout_ids = workouts.map{|workout| workout.id}
    data = workout_ids.map{|workout_id| ::Sessions::Details.new(workout_id).format_data(nil)}.reject{|d| d.empty?}
    result = []
    data.map{|workSess| 
      
      sessHash = {}
      workSess.map{|detail| 
        
        if sessHash[detail[:session_id]]
          sessHash[detail[:session_id]].push(detail)
        else 
          sessHash[detail[:session_id]] = [detail]
        end
      }
      workoutSessions = {workSess[0][:workout_title] => sessHash}
      result << workoutSessions
    }
    result
  end 

  def grab_session_details(amount = nil) 
    data = ::Sessions::Details.new(self.id).format_data(amount)
    
  end

  def formatted_workout
    warmup = formatData(self.warmup.sort_by! {|hash| hash["phase_position"]})
    body = formatData(self.body.sort_by! {|hash| hash["phase_position"]})
    cool_down = formatData(self.cool_down.sort_by! {|hash| hash["phase_position"]})
    
    workout = {warmup: warmup, body: body, cool_down: cool_down}
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
  
  private 
  
  def formatData(data) 
    circuit_arr = [] 
    sorted_objs = []
    circ_arr_phase_pos = 0    
    
    data.each do |record| 
      puts record
      
      if record["circuit_type"] == "circuit" && record["circuit_position"] == 1 && circuit_arr.length == 0
        circuit_arr.push(record)
        circ_arr_phase_pos = record["phase_position"]
      elsif record == data[-1] && record["circuit_type"] == "circuit" && circuit_arr.length > 0 && record["circuit_id"] == circuit_arr[0]["circuit_id"]
        circuit_arr.push(record)
        circuit_arr.sort_by! {|hash| hash["circuit_position"]}
        sorted_objs.push({circ_arr_phase_pos => circuit_arr})
        circ_arr_phase_pos = 0
        circuit_arr = []
      elsif record["circuit_type"] == "circuit" && circuit_arr.length > 0 && record["circuit_id"] == circuit_arr[0]["circuit_id"]
        circuit_arr.push(record)
      elsif record["circuit_type"] == "stack"
        if circuit_arr.length > 1
          circuit_arr.sort_by! {|hash| hash["circuit_position"]}
          sorted_objs.push({circ_arr_phase_pos => circuit_arr})
          circ_arr_phase_pos = 0
          circuit_arr = []
        end
        sorted_objs.push({record["phase_position"] => [record]})
      end
    end
    
    sorted_objs
  end




end
