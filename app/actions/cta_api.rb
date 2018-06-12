#Class for calling CTA_APIs

class CTA_API
        @bs_url = "http://lapi.transitchicago.com/api/1.0/"
        @neck = ".aspx?key="
        @key = "970303fe25e84759b8ebd74ba141cc6f"
        @tail = "&outputType=JSON"   
    
    def initialize

    end
    
    
    #Calls Location API from CTA and return parsed JSON
    #rt_nm = route name (default = "P" (purple line))
    def self.location(rt_nm = "p")
        require "open-uri"
        api = "ttpositions"
        para = "&rt=" +  rt_nm
        req_url = @bs_url + api + @neck + @key + para + @tail
        
        tJson = open(req_url).read
        api_response = ApiResponse.new
    
        prsJson = JSON.parse(tJson)

        api_response.payload = prsJson
        api_response.save
        
        return prsJson
    end
    
    
    #Calls follow this train API from CTA and return parsed JSON
    #rn_num = run number
    def self.follower(rn_num)
        require "open-uri"
        api = "ttfollow"
        para = "&runnumber=" + rn_num.to_s
        req_url = @bs_url + api + @neck + @key + para + @tail
    
        tJson = open(req_url).read
        prsJson = JSON.parse(tJson)
    
        return prsJson
    end
    
    
    #Calls follow this train API from CTA and return parsed JSON
    #st_id = stop id: 30010	Davis (Linden-bound)

    def self.arrival(stpId =30010 )
        require "open-uri"
        api = "ttarrivals"
        para = "&stpid=" + stpId
        req_url = @bs_url + api + @neck + @key + para + @tail
    
        tJson = open(req_url).read
        prsJson = JSON.parse(tJson)
    
        return prsJson
    end
    
    
    
   
    
end