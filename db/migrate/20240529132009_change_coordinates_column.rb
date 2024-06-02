class ChangeCoordinatesColumn < ActiveRecord::Migration[7.1]
  def change
  # Add GIST indexes for efficient spatial queries
  add_index :chargings, :coordinates, using: :gist
  add_index :ev_stations, :coordinates, using: :gist
  end
end
