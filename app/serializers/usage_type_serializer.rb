class UsageTypeSerializer < ActiveModel::Serializer
  attributes :id, :is_pay_at_location, :is_membership_required, :is_access_key_required, :title

end
