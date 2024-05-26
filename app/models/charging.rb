class Charging < ApplicationRecord
    include EnodeModule
    has_one :user, class_name: "user", foreign_key: "user_id"
    #has_one :ev_station, class_name: "ev_station", foreign_key: "ev_station_id"
    belongs_to :connection, optional: true
    after_save :update_ev_station_rating
    after_destroy :update_ev_station_rating
    belongs_to :user
    validates :user_id, presence: true  # Enforce presence of user_id

    attr_accessor :latitude, :longitude  # Add these attributes
    
    def self.calculate_charging_time(enode_vehicle_id, connection_id, target_batery_hz)
        enode_access_token = EnodeModule.enode_login
        enode_vehicle = EnodeModule.get_enode_vehicle(enode_access_token, enode_vehicle_id)
        max_current = enode_vehicle['chargeState']['maxCurrent']
        connection = Connection.find(connection_id)
        connection_power = connection.power_kw
        charge_limit = enode_vehicle["chargeState"]["chargeLimit"]
        battery_level = enode_vehicle['chargeState']['batteryLevel']
        battery_capacity = enode_vehicle['chargeState']['batteryCapacity']
        battery_total_hz = battery_level.to_f * battery_capacity.to_f / 100.0
        charging_hz = max_current < connection_power ? max_current : connection_power

        hz_to_be_charged = target_batery_hz - battery_total_hz
        charging_time = hz_to_be_charged / charging_hz * 60
        puts  charging_hz, battery_total_hz 
        
       # puts battery_capacity, battery_level, charge_limit, connection_power, max_current
        return charging_time

    end

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
        longitude = params[:longitude]
        latitude = params[:latitude]
        @charging.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
        @charging.user_id = current_user_id
        return @charging


        
    end




    scope :for_month, ->(month, year) {
        start_date = Date.new(year, month, 1).beginning_of_day # Use Date for flexibility
        end_date = start_date.end_of_month.end_of_day         # Explicitly end of day
        where(start_time: start_date..end_date)
    }

    

    

    
    # def login_to_enode
    #     Dotenv.load('.env')
    #     client_id = ENV['ENODE_CLIENT_ID']
    #     client_secret = ENV['ENODE_CLIENT_SECRET']
    #     url = "https://oauth.sandbox.enode.io/oauth2/token"
    #     #client_id = Base64.encode64(client_id)
    #     #client_secret = Base64.encode64(client_secret)
    #     basic_auth = { username: client_id, password: client_secret }
    #     payload = { grant_type: 'client_credentials' }

    #     begin
    #         response = RestClient::Request.execute(
    #             method: :post,
    #             url: url,
    #             user: client_id,
    #             password: client_secret,
    #             payload: payload
    #         )
    #         if response.code != 200
    #             puts "Error: #{response.code}, #{JSON.parse(response.body)['error']}, #{JSON.parse(response.body)['error_description']}"
    #             return nil
    #         end
    #         access_token = JSON.parse(response.body)['access_token']
    #         puts access_token
    #         return access_token
    #     rescue RestClient::ExceptionWithResponse => e
    #         puts "Error: #{e.response}"
    #     end     
    # end


    

end


