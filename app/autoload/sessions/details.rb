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

        CIRUIT_EXERCISES_SESSION_DETAILS_BY_DATE_SQL = <<~SQL.squish 
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
            where s.created_at between :start_date and :end_date
        SQL

        attr_reader :stats, :workout_id

        def initialize(workout_id, start_date = nil, end_date = nil)
            @workout_id = workout_id
            @start_date = start_date if start_date
            @end_date = end_date if end_date
            @stats = (start_date.present? && end_date.present?) ? get_stats_by_date : get_stats
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

                #    byebug

                   dataHash = {workout_title: workout_title, workout_id: workout_id, exercise_name: name, aggregate_reps: reps, total_active_time: aT, total_rest_time: rP, set_att_data: atts, total_time: (aT + rP), session_id: session_id } 
                    
                   dataArr << dataHash
                end
            end
            dataArr
        end

        def format_data_by_dates
            byebug
            group_by_session
            # iterate through the session and process into 
        end

        def format_data_by_exercise(amount = nil)
            dataHash ={}
            workout_title = ''
            workout_id = nil
            exArr = []
            number_of_records(amount).each do |session| 
                # this is a group of cesd records

                session_id = session[1][0]['session_id']
                group_by_exercise(session[1]).each do |_key, cesd_ex_group|
                    # byebug
                    if cesd_ex_group != nil
                        name = cesd_ex_group.first['exercise_name']
                        workout_id = cesd_ex_group.first['workout_id']
                        workout_title = Workout.find(workout_id).title
                        exHash = {}

                        cesd_ex_group.each do |sessionHash| 
                            # byebug
                            if exHash[name]
                                exHash[name] << sessionHash['circuit_exercises_session_details_stats']
                            else 
                                exHash[name] = [sessionHash['circuit_exercises_session_details_stats']]
                            end
                        end
                        # byebug 
            
                        date = cesd_ex_group.first['session_date'].strftime("%B %d, %Y")
                        
                        if dataHash[name]
                            # dataHash[name] << {cesd_ex_group.first['session_date'].strftime("%B %d, %Y") => exHash}
                            dataHash[name][date] ? (dataHash[name][date] << exHash) : (dataHash[name][date] = [exHash])
                        else 
                            
                            dataHash[name] = {}
                            dataHash[name][date] ? (dataHash[name][date] << exHash) : (dataHash[name][date] = [exHash])
                        end
                    end 
                   
                end
            end
            dataHash[:workout_id] = workout_id if workout_id.present?
            data = {workout_title => dataHash}
            data

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
        
        def circuit_exercises_session_details_by_date_sql_binds
            {
                workout_id: @workout_id,
                start_date: @start_date,
                end_date: @end_date,
            }
        end
        
        def get_stats
            ::Workout.find_by_sql([CIRUIT_EXERCISES_SESSION_DETAILS_SQL, circuit_exercises_session_details_sql_binds])
        end

        def get_stats_by_date
            ::Workout.find_by_sql([CIRUIT_EXERCISES_SESSION_DETAILS_BY_DATE_SQL, circuit_exercises_session_details_by_date_sql_binds])
        end

    end
end 

