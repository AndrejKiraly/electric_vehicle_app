class Connection < ApplicationRecord
    belongs_to :ev_station, class_name: "EvStation", foreign_key: "id"
    has_many :chargings

end
