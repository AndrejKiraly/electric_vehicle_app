class AddAmenitiesColumnToStation < ActiveRecord::Migration[7.1]
  def change
    create_join_table :ev_stations, :amenities do |t|
      t.index [:ev_station_id, :amenity_id]
      t.index [:amenity_id, :ev_station_id]
    end
  end
end
