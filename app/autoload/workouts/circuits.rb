# frozen_string_literal: true
# c.sets as circuit_sets,
require 'json'
module Workouts 
    class Circuits 
        CIRUIT_EXERCISES_BY_PHASE_SQL = <<~SQL.squish 
        select 
                c.phase as circuit_phase,
                c.circuit_type as circuit_type,
                c.position as phase_position,
                ce.position as circuit_position,
                c.sets as circuit_sets,
                e.id as ex_id,
                e.exercise_name as ex_name, 
                ce.ex_attributes as circuit_exercise_attributes,
                e.description as ex_description,
                w.id as workout_id,
                c.id as circuit_id,
                ce.id as circuit_exercise_id
            from workouts w
            inner join workout_circuits wc
                on wc.workout_id = w.id
            inner join circuits c 
                on c.id = wc.circuit_id
            inner join circuit_exercises ce
                on ce.circuit_id = c.id
            inner join exercises e 
                on e.id = ce.exercise_id
            where w.id = :workout_id 
                and c.phase = :phase 
        SQL


        def initialize(workout_id)
            @workout_id = workout_id
        end

        def find_by_phase(phase)
            ::Workout.find_by_sql([CIRUIT_EXERCISES_BY_PHASE_SQL, circuit_exercises_by_phase_sql_binds(phase)]).map{|res|
                res.attributes
            }
        end

        private 

        def circuit_exercises_by_phase_sql_binds(phase)
            { 
                workout_id: @workout_id,
                phase: phase,

            }
        end
    end
end 

