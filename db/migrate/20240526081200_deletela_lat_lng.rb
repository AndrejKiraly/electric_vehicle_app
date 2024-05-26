class DeletelaLatLng < ActiveRecord::Migration[7.1]
  def change
    remove_column :ev_stations, :latitude, :decimal, precision: 10, scale: 7
    remove_column :ev_stations, :longitude, :decimal, precision: 10, scale: 7
    remove_column :chargings, :latitude, :decimal, precision: 10, scale: 7
    remove_column :chargings, :longitude, :decimal, precision: 10, scale: 7
  end
end
