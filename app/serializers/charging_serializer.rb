class ChargingSerializer < ActiveModel::Serializer
  attributes :id, :battery_level_start, :battery_level_end, :price, :energy_used, :rating, :comment, :start_time, :end_time, :is_finished, :user_id, :vehicle_id, :connection_id, :latitude, :longitude

  
end
