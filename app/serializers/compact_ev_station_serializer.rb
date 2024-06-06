class CompactEvStationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :address_line, :rating, :is_free,  :usage_type_id, :distance

  attribute :distance do
    object.distance
  end


  attribute :latitude do
    object.coordinates.y
  end

  attribute :longitude do
    object.coordinates.x
  end

end
