class ChargingSerializer < ActiveModel::Serializer
  attributes :id, :battery_level_start, :battery_level_end, :price, :energy_used,
   :rating, :comment, :start_time, :end_time, :is_finished, :user_id, :vehicle_id, :connection_id, :latitude, :longitude, :ev_station_id


  attribute :ev_station_id do
    if object.connection
    object.connection.ev_station_id
    end
  end
  
  attribute :latitude do
    object.coordinates.y
  end

  attribute :longitude do
    object.coordinates.x
  end
    
end
