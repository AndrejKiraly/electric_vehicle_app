# app/services/charging_creator.rb
class ChargingCreator

    def calculate_total_energy_used(vehicle_route, chargings, usable_battery_capacity)
      # Ensure parameters are valid
      
      total_energy_used = 0.0
      if chargings.empty?
         
        total_energy_used = usable_battery_capacity * (vehicle_route.battery_start - vehicle_route.battery_end) / 100
      else
       
      # Constants and Initial Values

      
      current_battery_level = vehicle_route.battery_start
    
      # Energy used before first charge
      total_energy_used += (current_battery_level - chargings.first.battery_level_start) / 100.0 * usable_battery_capacity
    
      # Energy used during charging sessions
      total_energy_used += chargings.sum(:energy_used)
    
      # Energy used after last charge
      total_energy_used += (chargings.last.battery_level_end - vehicle_route.battery_end) / 100.0 * usable_battery_capacity

      end
      return total_energy_used
    end
  end


  # def initialize(params)
    #   @params = params
    # end
  
    # def create
    #   set_lat_lng
      
    #   @charging = Charging.new(@params)
    #   Rails.logger.info("Charging params: #{@params}")
    #   longitude, latitude = @params[:coordinates]
    #  # @charging.latitude= latitude
    #   @charging.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(12, 23)
      
    # end
  
    # private
  
    # def set_lat_lng
    #   if @params[:connection_id].present?
    #     ev_station = EvStation.find(Connection.find(@params[:connection_id]).ev_station_id)
    #     @params[:latitude] = ev_station.coordinates.latitude
    #     @params[:longitude] = ev_station.coordinates.longitude

    #   end
    # rescue ActiveRecord::RecordNotFound
    #   raise ActiveRecord::RecordNotFound, 'Station not found'
    # end
  