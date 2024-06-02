class EvStation < ApplicationRecord
    EARTH_RADIUS = 6371.0
    has_many :connections, dependent: :destroy
    has_many :chargings, through: :connections, dependent: :destroy
    belongs_to :user_id, class_name: 'User', foreign_key: 'created_by_id'

    has_paper_trail :skip => [:created_at, :updated_at]

    has_and_belongs_to_many :amenities, dependent: :destroy
    belongs_to :source
    belongs_to :usage_type
    belongs_to :country, optional: true

    attr_accessor :latitude, :longitude, :distance  # Add these attributes
    
    
  
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
      ev_stations = ev_stations.min_power(params[:power_kw]) 

      if params[:connection_type_ids].present?
      ev_stations = ev_stations.connection_type(params[:connection_type_ids].scan(/\d+/).map(&:to_i))
      end
      
      if params[:amenity_ids].present?
        amenity_ids = params[:amenity_ids].scan(/\d+/).map(&:to_i)
        ev_stations = ev_stations.amenities(amenity_ids)
      end
      
      if params[:usage_type_ids].present?
        ev_stations = ev_stations.usage_types(params[:usage_type_ids].scan(/\d+/).map(&:to_i))
      end

      
      
      
    }

    def self.distance_from_point(lng, lat)
      find_by_sql(["
        SELECT 
          id,
          ST_Distance(
            coordinates::geography, 
            ST_SetSRID(ST_MakePoint(?, ?), 4326)::geography
          ) AS distance_in_meters
        FROM 
          stations
        ", lng, lat])
    end
  
  
    def self.is_unique(uuid, country_id, source_id, existing_stations)
        # If station was created in app does not need to check uuid from openchargemap
      for existing_station in existing_stations
        if existing_station.uuid == uuid
          return false
        end
      end
      return true
    
    end      
      
        
  
    
    def update_rating!
      update(
        rating: chargings.where.not(rating: 0).average(:rating),
        user_rating_total: chargings.where.not(rating: 0).count
      )
    end

    def self.createStation(params, current_user_id)
        # Station is unique, proceed with creating the record
        @ev_station = EvStation.new(
          params
        )
        @ev_station.created_by_id = current_user_id
        @ev_station.updated_by_id = current_user_id
        @ev_station.amenity_ids = params[:amenity_ids]
        longitude = params[:longitude]
        latitude =  params[:latitude]
        Rails.logger.debug("latitude #{latitude},#{longitude}")
        @ev_station.coordinates = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
        #@ev_station.country = Country.where(id: 1)    #Country.where(title: params[:country_string]).first.id
        return @ev_station
    end

    def self.generate_stations_from_open_charge_maps(countrycode, current_user_id)
        stations_data = OpenChargeMapService.fetch_stations_data(countrycode)
        if stations_data.nil?
          return "Could not fetch data from OpenChargeMap API"
        end
        stations = []
        count = 0
        stations_data.each do |station_data|
          count = count + 1
          country_id = station_data["AddressInfo"]["Country"]["ID"]
          uuid = station_data["UUID"]
          existing_stations= EvStation.all.where(country_id: country_id, source_id: 1)
          if EvStation.is_unique(uuid, country_id, 1, existing_stations) && station_data.present?
            @ev_station = OpenChargeMapService.deserialize_station(station_data, current_user_id, country_id, uuid)
            if @ev_station.save
              if OpenChargeMapService.add_connections(station_data, @ev_station, current_user_id) != "success"
                return "Error creating connection: #{@ev_station.id}"
              end
              stations << @ev_station
            end
          else
            # Skip saving non-unique stations
            next
          end
        end

        if stations.any?
            return  stations.count
        else
           return  "All stations were already created"
        end
    end



    # def distance(latitude,longitude)
    #   # Convert latitude and longitude from degrees to radians
    #   lat1_rad = latitude * Math::PI / 180
    #   lon1_rad = longitude * Math::PI / 180
    #   lat2_rad = self.latitude.to_f * Math::PI / 180
    #   lon2_rad = self.longitude.to_f * Math::PI / 180
    #   # Earth radius in kilometers
    #   radius = 6371.0

    #   # Haversine formula
    #   dlat = lat2_rad - lat1_rad
    #   dlon = lon2_rad - lon1_rad
    #   a = Math.sin(dlat / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon / 2) ** 2
    #   c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    #   distance = radius * c

    #   return distance

    # end



end
