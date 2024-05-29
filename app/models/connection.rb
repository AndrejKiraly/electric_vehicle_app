class Connection < ApplicationRecord
    belongs_to :ev_station
    has_many :chargings, dependent: :destroy
    belongs_to :user_id, class_name: 'User', foreign_key: 'created_by_id'
    
    belongs_to :connection_type
    belongs_to :current_type
    

end
