class CompactEvStationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :address_line, :rating, :is_free,  :usage_type_id, :distance#, :connections, :amenities

  #debugger
  attribute :distance do
    object.distance
  end


  attribute :latitude do
    object.coordinates.y
  end

  attribute :longitude do
    object.coordinates.x
  end



  #belongs_to :connections, serializer: ConnectionSerializer
  #belongs_to :amenities, serializer: AmenitySerializer
end
