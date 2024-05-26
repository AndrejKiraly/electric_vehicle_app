class EvStation < ApplicationRecord
    has_many :connections, dependent: :destroy
    has_many :chargings, through: :connections, dependent: :destroy
    has_and_belongs_to_many :amenities, dependent: :destroy
   
    belongs_to :usage_type
    belongs_to :country, optional: true

    attr_accessor :latitude, :longitude  # Add these attributes
    #accepts_nested_attributes_for :amenities
    EARTH_RADIUS = 6371.0
  
    # scope :near, ->  (latitude, longitude, distance) {
    #   where("
    #   acos(sin(radians(#{latitude})) * sin(radians(latitude)) + 
    #   cos(radians(#{latitude})) * cos(radians(latitude)) * 
    #   cos(radians(longitude) - radians(#{longitude}))) <= ?", distance / EARTH_RADIUS)
    # }


    scope :is_free,          ->(value) { where(is_free: value) if value.present? }
    #scope :usage_type,       ->(id)    { where(usage_type_id: id) if id.present? }
    scope :fast_charge,      ->(value) { joins(:connections).where(connections: { is_fast_charge_capable: value }) if value.present? }
    scope :current_type,     ->(id)    { joins(:connections).where(connections: { current_type_id: id }) if id.present? }
    scope :connection_type,  ->(id)    { joins(:connections).where(connections: { connection_type_id: id }) if id.present? }
    scope :min_power,        ->(kw)    { joins(:connections).where("connections.power_kw > ?", kw) if kw.present? }
    scope :amenities,        ->(ids)   { joins(:amenities).where(amenities: { id: ids }) if ids.present? }
    scope :usage_types,      ->(ids)   { where(usage_type_id: ids) if ids.present? }
    scope :connection_types, ->(ids)   { joins(:connections).where(connections: { connection_type_id: ids }) if ids.present? }
    scope :rating,           ->(rating) { where("rating >= ?", rating) if rating.present? }
    scope :country,          ->(country_id) { where(country_id: country_id) if country_id.present? }
    # scope :within_bounds,    ->(sw, ne) {
    #   bounds_sw_lat = sw.split(",")[0].to_f
    #   bounds_ne_lat = ne.split(",")[0].to_f
    #   bounds_sw_lng = sw.split(",")[1].to_f
    #   bounds_ne_lng = ne.split(",")[1].to_f
    #   where("coordinates >= ? AND latitude <= ? AND longitude >= ? AND longitude <= ?", bounds_sw_lat, bounds_ne_lat, bounds_sw_lng, bounds_ne_lng)
    # }
    scope :within_coords, ->(sw,ne) {
      bounds_sw_lat = sw.split(",")[0].to_f
      bounds_ne_lat = ne.split(",")[0].to_f
      bounds_sw_lng = sw.split(",")[1].to_f
      bounds_ne_lng = ne.split(",")[1].to_f
      where("ST_DWithin(coordinates, ST_MakeEnvelope(?, ?, ?, ?, 4326)::geography, ?)", bounds_sw_lng, bounds_sw_lat, bounds_ne_lng, bounds_ne_lat, 10000)
  }
  
    scope :filter_stations, ->(params) {
      ev_stations = EvStation.all.within_coords(params[:bounds_sw], params[:bounds_ne])
      ev_stations = ev_stations.is_free(params[:is_free]) 
      ev_stations = ev_stations.fast_charge(params[:is_fast_charge_capable]) 
      ev_stations = ev_stations.current_type(params[:current_type_id]) 
      ev_stations = ev_stations.connection_type(params[:connection_type_id]) 
      ev_stations = ev_stations.min_power(params[:power_kw])
      ev_stations = ev_stations.amenities(params[:amenity_ids]) 
      ev_stations = ev_stations.usage_types(params[:usage_type_ids]) 
      ev_stations = ev_stations.connection_types(params[:connection_type_ids])
      ev_stations = ev_stations.rating(params[:rating]) 
  }

    
  
    
      
    # Ex:- scope :active, -> {where(:active => true)}
  
      def self.is_unique(uuid, country_id, source)
          
  
          # If station was created in app does not need to check uuid from openchargemap
          if source == "From Mobile App"
            return true
          end
          existing_stations = EvStation.all.where(country_id: country_id)
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
  
    def as_json(options = {})
      include_distance = options.delete(:include_distance)
      json = super(options)
      json[:distance] = options[:distance] if include_distance
      json
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
        @ev_station.country_id = Country.where(title: params[:country_string]).first.id
        return @ev_station
        
    end

  #   # Apply conditions only if there are any
  #   if conditions.any?
  #     ev_station_ids = Connection.where(is_fast_charge_capable: true).where("voltage < ?", 30).pluck(:ev_station_id)
  #     ev_stations = ev_stations.where(id: ev_station_ids)
  #     #ev_stations = ev_stations.includes(:connections).where(connections: {is_fast_charge_capable: true, voltage: <30}) #.where(conditions.join(' AND '), *params.values)
  #   end

  #   # ev_stations = ev_stations.where(id: ev_station_ids)
  
  #   return ev_stations
  # end

end
