# app/services/charging_creator.rb
class ChargingCreator
    def initialize(params)
      @params = params
    end
  
    def create
      set_lat_lng
      
      @charging = Charging.new(@params)
      Rails.logger.info("Charging params: #{@params}")
      longitude, latitude = @params[:coordinates]
     # @charging.latitude= latitude
      @charging.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(12, 23)
      
      
      

    end
  
    private
  
    def set_lat_lng
      if @params[:connection_id].present?
        ev_station = EvStation.find(Connection.find(@params[:connection_id]).ev_station_id)
        @params[:latitude] = ev_station.coordinates.latitude
        @params[:longitude] = ev_station.coordinates.longitude

      end
    rescue ActiveRecord::RecordNotFound
      raise ActiveRecord::RecordNotFound, 'Station not found'
    end

    

   

  end
  