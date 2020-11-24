class Workout < ApplicationRecord
  belongs_to :folder, required: true
  has_many :sessions, dependent: :destroy
  has_many :workout_circuits, dependent: :destroy
  has_many :circuits, through: :workout_circuits

  def handleCircuitDeletion
    warmup = formatData(self.warmup.sort_by! {|hash| hash["phase_position"]})
    body = formatData(self.body.sort_by! {|hash| hash["phase_position"]})
    cool_down = formatData(self.cool_down.sort_by! {|hash| hash["phase_position"]})
    
    updatePhasePos(warmup)
    updatePhasePos(body)
    updatePhasePos(cool_down)
    
  end



  def self.grab_all_workouts_with_session_details(workouts)
    workout_ids = workouts.map{|workout| workout.id}
    data = workout_ids.map{|workout_id| ::Sessions::Details.new(workout_id).format_data_by_exercise(nil)}.reject{|d| d.empty?}

    results = data.filter{|workSess| !workSess.first[1].empty? }
    results
    
  end 

  def grab_session_details(amount = nil) 
    data = ::Sessions::Details.new(self.id).format_data(amount)
    
  end

  def grab_session_details_by_date(start_date, end_date)
    byebug
    data = ::Sessions::Details.new(self.id, start_date, end_date).format_data_by_dates

  end

  def grab_session_details_by_exercise(amount)
    byebug
    data = ::Sessions::Details.new(self.id).format_data_by_exercise(amount)

  end

  def formatted_workout
    warmup = formatData(self.warmup.sort_by! {|hash| hash["phase_position"]})
    body = formatData(self.body.sort_by! {|hash| hash["phase_position"]})
    cool_down = formatData(self.cool_down.sort_by! {|hash| hash["phase_position"]})
    updatePhasePos(warmup)
    updatePhasePos(body)
    updatePhasePos(cool_down)
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

  def updatePhasePos(phaseArr)
    phaseArr.each_with_index.map{ |circuit, ind| 
      id = circuit.first[1][0]["circuit_id"]
      Circuit.find(id).update_attribute(:position, ind+1)
    }
  end
  
  def formatData(data) 
    circuit_arr = [] 
    sorted_objs = []
    circ_arr_phase_pos = 0   

    
    data.each do |record| 
      if record["circuit_type"] == "circuit"  && circuit_arr.length == 0
        circuit_arr.push(record)
        circ_arr_phase_pos = record["phase_position"]
      elsif record == data[-1] && record["circuit_type"] == "circuit" && circuit_arr.length > 0 && record["circuit_id"] == circuit_arr[0]["circuit_id"]
        circuit_arr.push(record)
        circuit_arr.sort_by! {|hash| hash["circuit_position"]}
        sorted_objs.push({circuit_arr[0]["phase_position"] => circuit_arr})
        # circ_arr_phase_pos = 0
        circuit_arr = []
      elsif record["circuit_type"] == "circuit" && circuit_arr.length > 0 && record["circuit_id"] == circuit_arr[0]["circuit_id"]
        circuit_arr.push(record)
      elsif record["circuit_type"] == "circuit" && circuit_arr.length > 0 
        circuit_arr.sort_by! {|hash| hash["circuit_position"]}
          sorted_objs.push({circuit_arr[0]["phase_position"] => circuit_arr})
          # circ_arr_phase_pos = 0
          circuit_arr = []
          circuit_arr.push(record)
      elsif record["circuit_type"] == "stack"
        if circuit_arr.length > 0
          circuit_arr.sort_by! {|hash| hash["circuit_position"]}
          sorted_objs.push({circuit_arr[0]["phase_position"] => circuit_arr})
          # circ_arr_phase_pos = 0
          circuit_arr = []
        end
        sorted_objs.push({record["phase_position"] => [record]})
      end
    end

    sorted_objs.sort_by{|record| record.keys()[0]}
  end




end
