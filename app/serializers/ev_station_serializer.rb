class EvStationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :name, :address_line, :city, :country_string, 
    :post_code, :uuid, :source, :phone_number, :email, :operator_website_url, 
    :rating, :user_rating_total, :is_membership_required, :is_access_key_required, 
    :is_pay_at_location, :is_free, :open_hours, :access_type_title, :access_comments, 
    :energy_source, :limit_time, :instruction_for_user, :price_information, 
    :created_at, :updated_at, :created_by_id, :updated_by_id, :usage_type, :amenities, :connections, :country


    belongs_to :country, serializer: CountrySerializer
    belongs_to :usage_type, serializer: UsageTypeSerializer
    has_many :connections, serializer: ConnectionSerializer
    belongs_to :amenities, serializer: AmenitySerializer

end
