class Connection < ApplicationRecord
    belongs_to :ev_station
    has_many :chargings, dependent: :destroy
    belongs_to :connection_type
    belongs_to :current_type

end
