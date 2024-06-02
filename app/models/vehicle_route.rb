class VehicleRoute < ApplicationRecord
    belongs_to :user
    has_many :chargings
end
