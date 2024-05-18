class CompactEvStationSerializerSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :address_line, :rating, :is_free, :amenities

  
  belongs_to :amenities, serializer: AmenitySerializer
end
