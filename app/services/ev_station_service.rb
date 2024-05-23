class EvStationService
    def initialize(params)
      @params = params
    end


    def call
        if @params[:bounds_sw] && @params[:bounds_ne]
            return within_bounds(@params[:bounds_sw], @params[:bounds_ne])
        else
            return 
        end
    end

    def within_bounds(sw, ne)
        bounds_sw_lat = sw.split(",")[0].to_f
        bounds_ne_lat = ne.split(",")[0].to_f
        bounds_sw_lng = sw.split(",")[1].to_f
        bounds_ne_lng = ne.split(",")[1].to_f
        ev_stations = EvStation.all.where("latitude >= ? AND latitude <= ? AND longitude >= ? AND longitude <= ?", bounds_sw_lat, bounds_ne_lat, bounds_sw_lng, bounds_ne_lng)
        return ev_stations
    end
end