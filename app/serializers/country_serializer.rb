class CountrySerializer < ActiveModel::Serializer
  attributes :id, :title, :iso_code
end
