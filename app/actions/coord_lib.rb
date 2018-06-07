class Coord_Lib
    
    # bound = North:1, South:5
    def self.get_coord(bound = 1)

        #get all unique combination of traveling direction and run numbers
        run_nums = CtaLoc.select(:trdr == bound).pluck(:rn).uniq
        
        coord_data = Hash.new()    #create new array
        #main loop
        run_nums.each do |run|
            temp = create_coord(run)
            coord_data.store(run, temp)
        end
        
        return coord_data
    
    end
    
    
    
    def get_data(date, line)
        temp = CtaLoc.all
        
        return temp.find_by(tmst: date)
    end
    
    # calculate absolute distance based on next station ID and gps location
    def self.calculate_dist(hash_in)
        
        #find record of next station ID from StopDatum
        nextStop = StopDatum.find_by(stop_id: hash_in.dig("nextstpid"))
        # binding.pry
        
        # Calculate relative distance
        # puts nextStop["lat"].to_f, nextStop["long"].to_f, hash_in["lat"].to_f, hash_in["lon"].to_f
        rel_dist = Geo_Lib.distance(nextStop["long"].to_f, nextStop["lat"].to_f, hash_in["lat"].to_f, hash_in["lon"].to_f)
        
        # absolute distance = absolute distance of station - distance to next station
        abs_dist = nextStop["abs_km"] - rel_dist
        
        # abs_dist = 0
        return abs_dist
    end
    
    
    def self.create_coord(rn)

        temp_loc = CtaLoc.where(rn: rn)
        # new 2 dimensional array 
        arr_temp = Array.new(1){ [0,0] }
        
        
        temp_loc.each_with_index  do |location, i|
            #Calculate absolute distance
            temp_loc = location.to_json
            arg_loc = JSON.parse(temp_loc)
            abs_dist = calculate_dist(arg_loc)
            if i == 0 then
                # Create new array
                arr_temp.push([location["tmst"], abs_dist])
                arr_temp = arr_temp.drop(1)
            else
                # Push it
                arr_temp.push([location["tmst"], abs_dist])
            end
        end
        
        # return {rn => arr_temp}
        
        return arr_temp
        
    end
    
    
    #format data to json
    def self.jsn_cnvt
        
    end
    
    
    
end