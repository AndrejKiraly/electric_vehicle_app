# app/services/charging_creator.rb
class ChargingCreator
    def initialize(params)
      @params = params
    end
  
    def create
      set_lat_lng
      
      Charging.new(@params)

    end
  
    private
  
    def set_lat_lng
      if @params[:connection_id].present?
        ev_station = EvStation.find(Connection.find(@params[:connection_id]).ev_station_id)
        @params[:latitude] = ev_station.latitude
        @params[:longitude] = ev_station.longitude
      end
    rescue ActiveRecord::RecordNotFound
      raise ActiveRecord::RecordNotFound, 'Station not found'
    end

    

   

  end
  