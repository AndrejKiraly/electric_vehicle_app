class CompactEvStationSerializerSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :address_line, :rating, :is_free,  :usage_type_id

  
  attribute :latitude do
    object.coordinates.y
  end

  attribute :longitude do
    object.coordinates.x
  end

  #belongs_to :amenities, serializer: AmenitySerializer
end
