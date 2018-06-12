class Coord_Lib
    
    # bound = North:1, South:5
    def self.get_coord(bound = 1)

        #get all unique combination of traveling direction and run numbers
        run_nums = CtaLoc.select(:trdr == bound).pluck(:rn).uniq
        
        coord_data = Hash.new()    #create new hash
        #main loop
        run_nums.each do |run|
            temp = create_coord(run, bound)
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
        
        # find root station ID from StopDatum
        
        case hash_in["trdr"].to_i
            when 1 then      # North bound
                root_station = StopDatum.find_by(abs_km: 0, trdr: 1)
                
            when 5 then     # South bound
                root_station = StopDatum.find_by(abs_km: 0, trdr: 5)
                
            else            # Assume its north bound
                root_station = StopDatum.find_by(abs_km: 0, trdr: 1)
        end
        
        
        # Calculate relative distance relative to root station
        rel_dist = Geo_Lib.distance(root_station["lat"].to_f, root_station["long"].to_f, hash_in["lat"].to_f, hash_in["lon"].to_f)
        # absolute distance = absolute distance of station - distance to next station
        abs_dist = root_station["abs_km"].to_f + rel_dist



        # Calculate relative distance
        # rel_dist = Geo_Lib.distance(nextStop["long"].to_f, nextStop["lat"].to_f, hash_in["lat"].to_f, hash_in["lon"].to_f)
        # absolute distance = absolute distance of station - distance to next station
        # abs_dist = nextStop["abs_km"] - rel_dist
        
        return abs_dist
    end
    
    
    def self.create_coord(rn, trdr)

        temp_loc = CtaLoc.where(rn: rn, trdr: trdr)
        # return {rn => arr_temp}
        return jsn_cnvt(temp_loc)
        # return arry_cnvt(temp_loc)
        
    end
    
    
    #format data to json
    def self.jsn_cnvt(temp_loc)
        
        ret_hash = Hash.new()    #create new hash
        
        #main loop
        temp_loc.each_with_index  do |location|
            #Calculate absolute distance
            temp_loc = location.to_json
            arg_loc = JSON.parse(temp_loc)
            
            abs_dist = calculate_dist(arg_loc)
            tmst_val = location["tmst"]
            
            ret_hash.store(tmst_val, abs_dist)
        end
        
        # return {rn => arr_temp}
        return ret_hash
        
        
        
    end
    
    
    def self.arry_cnvt(temp_loc)
        # new 2 dimensional array 
        tmst_arr=Array.new
        loc_arr = Array.new
        
        temp_loc.each_with_index  do |location|
            #Calculate absolute distance
            temp_loc = location.to_json
            arg_loc = JSON.parse(temp_loc)
            abs_dist = calculate_dist(arg_loc)
            
            tmst_arr.push(location["tmst"])
            loc_arr.push(abs_dist)
        end
        
        # return {rn => arr_temp}
        return {"tmst" => tmst_arr, "abs_loc" =>  loc_arr}
        
        
        
    end
    
    
    
    
    
    
    
end