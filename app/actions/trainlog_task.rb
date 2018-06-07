class TrainlogTask
    
    #loop main task with specified delay and cycle number
    def self.tester(delay_t, cycle_n)
        for i in 1..cycle_n
            main
            puts i
            sleep(delay_t)
        end
        
        
    end
    
    #Collect data from CTA_API
    def self.main
        #define local variables
        temp_rn = Array.new() #store run numbers (local)
        rn_log = Array.new() #store train log data
        rn_loc = Array.new() #store return from location API
        mode = 1 #skips the run number->train follower logic sequence
        
        # get "locations" for purple line
        ret_loc = CTA_API.location("p")
        if ret_loc.dig("ctatt", "errCd") == 0 then
            dat =  ret_loc.dig("ctatt", "route", 0, "train") 
            tmst = {"tmst" => ret_loc.dig("ctatt", "tmst")}
        
            if mode == 1 then
                #get all run numbers first
                for train in dat do
                    temp_rn.push(train.dig("rn"))
                end
                 
                 #for all current run numbers, get position and relavant information
                 for run_num in temp_rn do
                     ret_fol = CTA_API.follower(run_num)
                     #Check if there is any error code returned
                     if ret_fol.dig("ctatt", "errCd") == 0 then
                         #Do only when no error
                         tmst= {"tmst" => ret_fol.dig("ctatt", "tmst")}
                         temp = ret_fol.dig("ctatt", "eta",0)
                         temp = temp.merge(tmst)
                         rn_log.push(temp)
                    end
                 end
             end
    
            # store location data in DB 
            for train in dat do
                location = Hash.new()
                location = tmst.merge(train)
                rn_loc.push(location)
                reg_locDB(location)
            end
        end

         
        # puts temp_rn
        # puts rn_loc
        # puts rn_log
         
         
        #  return rn_loc
        #  return rn_log
         
    end
    
    
    def self.reg_locDB(train_loc)
        temp = CtaLoc.new
        temp.rn = train_loc["rn"]
        temp.tmst = train_loc["tmst"]
        temp.destst = train_loc["destSt"]
        temp.destnm = train_loc["destNm"]
        temp.trdr = train_loc["trDr"]
        temp.nextstaid = train_loc["nextStaId"]
        temp.nextstpid = train_loc["nextStpId"]
        temp.nextstanm = train_loc["nextStaNm"]
        temp.prdt = train_loc["prdt"]
        temp.arrt = train_loc["arrT"]
        temp.isapp = train_loc["isApp"]
        temp.isdly = train_loc["isDly"]
        temp.flags = train_loc["flags"]
        temp.lat = train_loc["lat"]
        temp.lon = train_loc["lon"]
        temp.heading = train_loc["heading"]
        temp.save
    end
    
    private_class_method :reg_locDB
    
end



