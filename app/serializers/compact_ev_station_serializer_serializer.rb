class CompactEvStationSerializerSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :address_line, :rating, :is_free, :amenities, :usage_type_id

  
  belongs_to :amenities, serializer: AmenitySerializer
end
