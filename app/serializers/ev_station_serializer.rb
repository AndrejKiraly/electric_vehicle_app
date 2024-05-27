class EvStationSerializer < ActiveModel::Serializer
  attributes :id, :name, :address_line, :city, :country_string, 
    :post_code, :uuid, :phone_number, :email, :operator_website_url, 
    :rating, :user_rating_total,  
     :is_free, :open_hours, 
    :instruction_for_user, :price_information, 
    :created_at, :updated_at, :created_by_id, :updated_by_id, :latitude, :longitude,
     :source_id,
     :usage_type_id, :amenity_ids, :country_id, :source, :connections

  attribute :latitude do
    object.coordinates.y
  end

  attribute :longitude do
    object.coordinates.x
  end
  
    belongs_to :source, serializer: SourceSerializer
    belongs_to :country, serializer: CountrySerializer
    belongs_to :usage_type, serializer: UsageTypeSerializer
    has_many :connections, serializer: ConnectionSerializer
    belongs_to :amenities, serializer: AmenitySerializer

end
