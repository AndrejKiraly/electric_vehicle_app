class AddUsageTypeToStation < ActiveRecord::Migration[7.1]
  def change
    add_reference :ev_stations, :usage_type, foreign_key: true
  end
end
