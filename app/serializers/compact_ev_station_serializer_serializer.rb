class CompactEvStationSerializerSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :address_line, :rating, :is_free,  :usage_type_id#, :connections, :amenities

  
  attribute :latitude do
    object.coordinates.y
  end

  attribute :longitude do
    object.coordinates.x
  end

  #belongs_to :connections, serializer: ConnectionSerializer
  #belongs_to :amenities, serializer: AmenitySerializer
end
