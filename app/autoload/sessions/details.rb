# frozen_string_literal: true

module Sessions 
    class Details 
        CIRUIT_EXERCISES_SESSION_DETAILS_SQL = <<~SQL.squish 
            select  
                s.workout_id as workout_id,
                s.id as session_id, 
                s.created_at as session_date,
                cesd.id as circuit_exercises_session_details_id,
                ce.id as circuit_exercise_id, 
                ce.circuit_id as circuit_id, 
                cesd.stats as circuit_exercises_session_details_stats,
                e.id as exercise_id, 
                e.exercise_name as exercise_name
            from sessions s 
            inner join circuit_exercise_session_details cesd
                on cesd.session_id = s.id 
            inner join circuit_exercises ce
                on ce.id = cesd.circuit_exercise_id
            inner join exercises e
                on e.id = ce.exercise_id 
            where s.workout_id = :workout_id;
        SQL

        attr_reader :stats, :workout_id

        def initialize(workout_id)
            @workout_id = workout_id
            @stats = get_stats
        end

        # must take an array of nested arrays
        def format_data(amount = nil) 
            dataArr = []

            number_of_records(amount).each do |session| 
                # this is a group of cesd records
                
                session_id = session[1][0]['session_id']
                group_by_exercise(session[1]).each do |_key, cesd_ex_group|
                    name = cesd_ex_group.first['exercise_name']
                    workout_id = cesd_ex_group.first['workout_id']
                    workout_title = Workout.find(workout_id).title
                   reps = aggregate(cesd_ex_group.pluck('circuit_exercises_session_details_stats').pluck('reps'))
                   aT = aggregate(cesd_ex_group.pluck('circuit_exercises_session_details_stats').pluck('activeTime'))
                   rP = aggregate(cesd_ex_group.pluck('circuit_exercises_session_details_stats').pluck('restPeriod'))
                   atts = cesd_ex_group.pluck('circuit_exercises_session_details_stats')

                   dataHash = {workout_title: workout_title, workout_id: workout_id, exercise_name: name, aggregate_reps: reps, total_active_time: aT, total_rest_time: rP, set_att_data: atts, total_time: (aT + rP), session_id: session_id } 
                    
                   dataArr << dataHash
                end
            end
            dataArr
        end

        
        
        private 

        def group_by_session 
            @stats.group_by do |stat| 
                stat.session_id
            end.sort_by{|val| val[0]}
        end

        def group_by_exercise(session)
            
            session.group_by do |cesd_record| 
                cesd_record.exercise_id
            end
        end

        def number_of_records(amount)
            amount.present? ? group_by_session.last(amount) : group_by_session
        end

        def aggregate(values) 
            values.map{|val| val.to_i }.sum
        end 

        def format_attribute_data()

        end
        
        def circuit_exercises_session_details_sql_binds
            { 
                workout_id: @workout_id,
            }
        end
        
        def get_stats
            ::Workout.find_by_sql([CIRUIT_EXERCISES_SESSION_DETAILS_SQL, circuit_exercises_session_details_sql_binds])
        end

    end
end 

