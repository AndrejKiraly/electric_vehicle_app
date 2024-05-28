class EvStation < ApplicationRecord
    has_many :connections, dependent: :destroy
    has_many :chargings, through: :connections, dependent: :destroy
    has_and_belongs_to_many :amenities, dependent: :destroy

    belongs_to :source
    belongs_to :usage_type
    belongs_to :country, optional: true

    attr_accessor :latitude, :longitude  # Add these attributes
    #accepts_nested_attributes_for :amenities
    EARTH_RADIUS = 6371.0
  


    scope :is_free,          ->(value) { where(is_free: value) if value.present? }
    scope :fast_charge,      ->(value) { joins(:connections).where(connections: { is_fast_charge_capable: value }) if value.present? }
    scope :current_type,     ->(id)    { joins(:connections).where(connections: { current_type_id: id }) if id.present? }
    scope :connection_type,  ->(id)    { joins(:connections).where(connections: { connection_type_id: id }) if id.present? }
    scope :min_power,        ->(kw)    { joins(:connections).where("connections.power_kw > ?", kw) if kw.present? }
    
    scope :amenities,        ->(ids)   { joins(:amenities).where(amenities: { id: ids }) if ids.present? }
    scope :usage_types,      ->(ids)   { where(usage_type_id: ids) if ids.present? }
    scope :connection_types, ->(ids)   { joins(:connections).where(connections: { connection_type_id: ids }) if ids.present? }
    scope :rating,           ->(rating) { where("rating >= ?", rating) if rating.present? }
    scope :country,          ->(country_id) { where(country_id: country_id) if country_id.present? }
    scope :within_coords, ->(bounds_sw_lat, bounds_sw_lng, bounds_ne_lat, bounds_ne_lng) {
      
      where("ST_DWithin(coordinates, ST_MakeEnvelope(?, ?, ?, ?, 4326)::geography, ?)", bounds_sw_lng, bounds_sw_lat, bounds_ne_lng, bounds_ne_lat, 0.0)
    }
    scope :within_distance, ->(longitude, latitude, distance) {
      where("ST_Distance(coordinates, ST_MakePoint(?, ?)::geography) < ?", longitude, latitude, distance)
    }
  
    scope :filter_stations, ->(params) {
      bounds_sw_lat = params[:bounds_sw].split(",")[0].to_f
      bounds_ne_lat = params[:bounds_ne].split(",")[0].to_f
      bounds_sw_lng = params[:bounds_sw].split(",")[1].to_f
      bounds_ne_lng = params[:bounds_ne].split(",")[1].to_f
      ev_stations = EvStation.all.within_coords(bounds_sw_lat, bounds_sw_lng, bounds_ne_lat, bounds_ne_lng)
      ev_stations = ev_stations.is_free(params[:is_free]) 
      ev_stations = ev_stations.fast_charge(params[:is_fast_charge_capable]) 
      ev_stations = ev_stations.current_type(params[:current_type_id])

      if params[:connection_type_ids].present?
      ev_stations = ev_stations.connection_type(params[:connection_type_ids].split(',').map(&:to_i))
      end
      ev_stations = ev_stations.min_power(params[:power_kw]) 

      
      if params[:amenity_ids].present?
        amenity_ids = params[:amenity_ids].split(',').map(&:to_i)
        ev_stations = ev_stations.amenities(amenity_ids.size > 1 ? amenity_ids : [params[:amenity_ids][0]])
        Rails.logger.debug("amenity_ids #{params[:amenity_ids]}")
      end
      
      if params[:usage_type_ids].present?
      ev_stations = ev_stations.usage_types(params[:usage_type_ids].split(',').map(&:to_i)) 
      end

      ev_stations = ev_stations.rating(params[:rating]).distinct 
      
    }
  
    def self.is_unique(uuid, country_id, source_id)
        # If station was created in app does not need to check uuid from openchargemap
      existing_stations= EvStation.all.where(country_id: country_id, source_id: source_id)
      for existing_station in existing_stations
        if existing_station.uuid == uuid
          puts "already in database"
          return false
        end
      end
      return true
    
    end      
      
        
  
    def distance(latitude,longitude)
      # Convert latitude and longitude from degrees to radians
      lat1_rad = latitude * Math::PI / 180
      lon1_rad = longitude * Math::PI / 180
      lat2_rad = self.latitude.to_f * Math::PI / 180
      lon2_rad = self.longitude.to_f * Math::PI / 180

      # Earth radius in kilometers
      radius = 6371.0

      # Haversine formula
      dlat = lat2_rad - lat1_rad
      dlon = lon2_rad - lon1_rad
      a = Math.sin(dlat / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon / 2) ** 2
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
      distance = radius * c

      return distance

    end

    def update_rating!
      update(
        rating: chargings.where.not(rating: 0).average(:rating),
        user_rating_total: chargings.where.not(rating: 0).count
      )
    end

    def self.createStation( params, current_user_id)
        # Station is unique, proceed with creating the record
        @ev_station = EvStation.new(
          params
        )
        @ev_station.created_by_id = current_user_id
        @ev_station.updated_by_id = current_user_id
        @ev_station.amenity_ids = params[:amenity_ids]
        longitude, latitude = params[:longitude], params[:latitude]
        Rails.logger.debug("latitude #{latitude},#{longitude}")
        @ev_station.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
        @ev_station.country_id = 1 #Country.where(title: params[:country_string]).first.id
        return @ev_station
    end

    def self.generateStationsFromOpenChargeMaps(countrycode, current_user_id)
      apikey= ENV['openChargeMapApiKey']
        
        request_url_openChargeMap= "https://api.openchargemap.io/v3/poi?key=#{apikey}&maxresults=100000000&countrycode=#{countrycode}"
        response = RestClient.get(request_url_openChargeMap)
        if response.code == 200
          stations_data = JSON.parse(response.body)
        else
          # Handle error case
          return "Could not fetch data from OpenChargeMap API"
        end
        stations = []
        count = 0

        stations_data.each do |station_data|
          count = count + 1
          country_id = station_data["AddressInfo"]["Country"]["ID"]
          uuid = station_data["UUID"]
          if EvStation.is_unique(uuid, country_id, 1) && station_data.present?
            if station_data["AddressInfo"].present?
              name = station_data["AddressInfo"]["Title"]
              latitude = station_data["AddressInfo"]["Latitude"]
              longitude = station_data["AddressInfo"]["Longitude"]
              address_line = station_data["AddressInfo"]["AddressLine1"]
              city = station_data["AddressInfo"]["Town"]
              country = station_data["AddressInfo"]["Country"]["Title"]
              country_id = station_data["AddressInfo"]["Country"]["ID"]
              post_code = station_data["AddressInfo"]["Postcode"]
              phone_number = station_data["AddressInfo"]["ContactTelephone1"] || "unknown"
              email = station_data["AddressInfo"]["ContactEmail"] || "unknown"
              coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
            end
            uuid = station_data["UUID"]
            if station_data["DataProvider"].present?
              source_id = 1
            end      
            if station_data["UsageType"].present?
              usage_type_id = station_data["UsageType"]["ID"]
            else
              usage_type_id = 0
            end
            limit_time = "Unknown"
            instruction_for_user = "Unknown"
            energy_source = "Unknown"
            if station_data["OperatorInfo"].present?
              operator_website_url = station_data["OperatorInfo"]["WebsiteURL"] || "unknown"
            end
            created_by_id = current_user_id 
            
            @ev_station = EvStation.new(
              name: name,
              address_line: address_line ? address_line : "",
              city: city ? city : "",
              country_string: country ? country : "",
              post_code: post_code ? post_code : "",
              uuid: uuid,
              source_id: source_id,
              created_by_id: created_by_id,
              updated_by_id: created_by_id,
              rating: 0.0,
              user_rating_total: 0,
              phone_number: phone_number ? phone_number : "",
              email: email ? email : "",
              usage_type_id: usage_type_id ? usage_type_id : 0,
              operator_website_url: operator_website_url ? operator_website_url : "",
              instruction_for_user: instruction_for_user ,
              coordinates: coordinates,
              country_id: country_id
              
            )           
            if @ev_station.save
              if  station_data["Connections"].present?
                connections_data = station_data["Connections"]
                connections_data.each_with_index do |connection_data, index|
                begin
                  if connection_data["ConnectionType"].present?
                    connection_type_id = connection_data["ConnectionType"]["ID"]
                  else
                    connection_type_id = 0
                  end
                  if connection_data["StatusType"].present?
                    is_operational_status = connection_data["StatusType"]["IsOperational"]
                  else
                    is_operational_status = false
                  end
                  if connection_data["Level"].present?
                    is_fast_charge_capable = connection_data["Level"]["IsFastChargeCapable"]
                  else
                    is_fast_charge_capable = false
                  end

                  if connection_data["CurrentType"].present?
                    current_type_id = connection_data["CurrentType"]["ID"]
                  else
                    current_type_id = 10
                  end
                  if connection_data["Amps"].present?
                    amps = connection_data["Amps"]
                  end
                  if connection_data["Voltage"].present?
                    voltage = connection_data["Voltage"]
                  end
                  if connection_data["PowerKW"].present?
                    power_kw = connection_data["PowerKW"]
                  end
                  if connection_data["Quantity"].present?
                    quantity = connection_data["Quantity"].to_i
                  end
                  
                  
          
                  # Create a new Connection object for each connection
                  connection = Connection.new(
                    connection_type_id: connection_type_id ? connection_type_id : 0,
                    is_operational_status: is_operational_status ,
                    is_fast_charge_capable: is_fast_charge_capable ,
                    current_type_id: current_type_id ,
                    amps: amps ? amps : 0,
                    voltage: voltage ? voltage : 0,
                    power_kw: power_kw ? power_kw : 0,
                    quantity: quantity ? quantity : 0,
                    created_by_id: created_by_id,
                    updated_by_id: created_by_id

                  )               
                  connection.ev_station = @ev_station
                  connection.save
                rescue => e
                  return "Error creating connection: #{e.message}, ev_station: #{@ev_station}"
                end
              end
            end
              stations << @ev_station
            end
          else
            # Skip saving non-unique stations
            next
          end
        end
    
        if stations.any?
            return  "#{stations.count}"
        else
            print count
           return  "All stations were already created"
        end

    end


end
