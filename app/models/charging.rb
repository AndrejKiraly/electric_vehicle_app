class Charging < ApplicationRecord
    include EnodeModule
    belongs_to :connection, optional: true
    belongs_to :user
    after_save :update_ev_station_rating
    after_destroy :update_ev_station_rating
    belongs_to :vehicle_route, optional: true
    
    validates :user_id, presence: true  # Enforce presence of user_id

    attr_accessor :latitude, :longitude  # Add these attributes

    scope :for_month, ->(month, year) {
        start_date = Date.new(year, month, 1).beginning_of_day # Use Date for flexibility
        end_date = start_date.end_of_month.end_of_day         # Explicitly end of day
        where(start_time: start_date..end_date)
    }
    
    def self.monthly_summary(month, year)
        chargings = Charging.all.for_month(month, year)
        chargings = chargings.where(is_finished: true)
        total_charging_cost = chargings.sum(:price) 
        total_energy_used = chargings.sum(:energy_used)
        
        summary_data = {
            total_charging_cost: total_charging_cost,
            total_energy_used: total_energy_used,
            chargings: chargings
        }
        return summary_data
    end

    def update_ev_station_rating
        if connection && connection.ev_station 
            connection.ev_station.update_rating!
        end
    end

    def self.createCharging(params, current_user_id)
        if params[:connection_id].present?
            connection = Connection.find_by(id: params[:connection_id])
            if connection.nil?
                return nil
            else
                #set coordinates from given connections ev_station
                ev_station = EvStation.find(Connection.find(params[:connection_id]).ev_station_id)
                params[:latitude] = ev_station.coordinates.y
                params[:longitude] = ev_station.coordinates.x
            end
        end
        @charging = Charging.new(params)
        if VehicleRoute.exists?(vehicle_id: params[:vehicle_id], is_finished: false)
            @charging.vehicle_route_id = VehicleRoute.find_by(vehicle_id: params[:vehicle_id], is_finished: false).id
        end
        longitude = params[:longitude]
        latitude = params[:latitude]
        @charging.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
        @charging.user_id = current_user_id
        return @charging



        # def self.calculate_charging_time(enode_vehicle_id, connection_id, target_batery_hz)
    #     enode_access_token = EnodeModule.enode_login
    #     enode_vehicle = EnodeModule.get_enode_vehicle(enode_access_token, enode_vehicle_id)
    #     max_current = enode_vehicle['chargeState']['maxCurrent']
    #     connection = Connection.find(connection_id)
    #     connection_power = connection.power_kw
    #     charge_limit = enode_vehicle["chargeState"]["chargeLimit"]
    #     battery_level = enode_vehicle['chargeState']['batteryLevel']
    #     battery_capacity = enode_vehicle['chargeState']['batteryCapacity']
    #     battery_total_hz = battery_level.to_f * battery_capacity.to_f / 100.0
    #     charging_hz = max_current < connection_power ? max_current : connection_power

    #     hz_to_be_charged = target_batery_hz - battery_total_hz
    #     charging_time = hz_to_be_charged / charging_hz * 60
    #     puts  charging_hz, battery_total_hz 
        
    #    # puts battery_capacity, battery_level, charge_limit, connection_power, max_current
    #     return charging_time

    # end
        
    end




    



    

end


