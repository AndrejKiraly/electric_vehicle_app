class Charging < ApplicationRecord
    has_one :user, class_name: "user", foreign_key: "user_id"
    has_one :ev_station, class_name: "ev_station", foreign_key: "ev_station_id"

end
