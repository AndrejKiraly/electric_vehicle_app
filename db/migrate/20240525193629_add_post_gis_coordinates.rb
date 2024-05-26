class AddPostGisCoordinates < ActiveRecord::Migration[7.1]
  def change
    add_column :chargings, :coordinates, :st_point, geographic: true
    add_column :ev_stations, :coordinates, :st_point, geographic: true
  end
end
