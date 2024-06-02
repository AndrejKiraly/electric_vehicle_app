class CreateVehicleRoutes < ActiveRecord::Migration[7.1]
  def change
    rename_table :routes, :vehicle_routes
  end
end
