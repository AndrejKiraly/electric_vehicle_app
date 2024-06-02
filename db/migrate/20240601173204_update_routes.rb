class UpdateRoutes < ActiveRecord::Migration[7.1]



  def change
    remove_column :vehicle_routes, :latitude_start, :decimal, precision: 10, scale: 7
    remove_column :vehicle_routes, :longitude_start, :decimal, precision: 10, scale: 7
    remove_column :vehicle_routes, :latitude_end, :decimal, precision: 10, scale: 7
    remove_column :vehicle_routes, :longitude_end, :decimal, precision: 10, scale: 7
    remove_column :vehicle_routes, :is_finished, :boolean
    remove_column :vehicle_routes, :end_time, :datetime
    remove_column :vehicle_routes, :distance, :float
    remove_column :vehicle_routes, :energy_used, :integer


    add_column :vehicle_routes, :distance, :float, default: 0
    add_column :vehicle_routes, :energy_used, :float, default: 0
    add_column :vehicle_routes, :end_time, :datetime, null: true
    add_column :vehicle_routes, :is_finished, :boolean, default: false
    add_column :vehicle_routes, :polyline, :line_string, geographic: true
    add_column :vehicle_routes, :battery_start, :integer
    add_column :vehicle_routes, :battery_end, :integer, null: true
    add_reference :chargings, :vehicle_route, foreign_key: true, null: true
    add_column :vehicle_routes, :vehicle_id, :string
    

  end
end
