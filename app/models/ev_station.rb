class EvStation < ApplicationRecord
    has_many :connections
    EARTH_RADIUS = 6371.0
  
    scope :near, ->  (latitude, longitude, distance) {
      where("
      acos(sin(radians(#{latitude})) * sin(radians(latitude)) + 
      cos(radians(#{latitude})) * cos(radians(latitude)) * 
      cos(radians(longitude) - radians(#{longitude}))) <= ?", distance / EARTH_RADIUS)
    }
    
  
    
      
    # Ex:- scope :active, -> {where(:active => true)}
  
      def self.is_unique(station_data)
          place_id = station_data["UUID"]
  
          # If station was created in app does not need to check uuid from openchargemap
          if station_data["source"] == "From Mobile App"
            return true
          end
          existing_stations = EvStation.all
          for existing_station in existing_stations
            if existing_station.uuid == place_id
              puts "already in database"
              return false
            end
          end
      
          return true
        end
  
      def filter_by_params(params)
        
        ev_stations = EvStation.where(nil)
        return ev_stations
  
      end
  
      def self.filter_by_params_dynamic(params)
        ev_stations = EvStation.all  # Start with all stations
        
        # Build conditions based on non-nil parameters
        conditions = []
        params.delete("distance")
        params.delete("lng")
        params.delete("lat")
        params.delete("controller")
        params.delete("action")
  
  
        params.each do |key, value|        
          connection_params = {}
          if key == "is_fast_charge_capable" && value != "null"
            conditions << "connections.is_fast_charge_capable = ?"
            
          end
  
          unless value.nil? || value == "null" || key = "is_fast_charge_capable" # Skip if value is nil
            conditions << "#{key} = ?"
          end
          if value.nil? || value == "null"
            params.delete(key)
          end
        end
      
        # Apply conditions only if there are any
        if conditions.any?
          ev_station_ids = Connection.where(is_fast_charge_capable: true).where("voltage < ?", 30).pluck(:ev_station_id)
          ev_stations = ev_stations.where(id: ev_station_ids)
          #ev_stations = ev_stations.includes(:connections).where(connections: {is_fast_charge_capable: true, voltage: <30}) #.where(conditions.join(' AND '), *params.values)
        end
  
        # ev_stations = ev_stations.where(id: ev_station_ids)
      
        return ev_stations
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
end
