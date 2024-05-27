class UuidDefault < ActiveRecord::Migration[7.1]
  def change
    remove_column :ev_stations, :uuid, :string
    add_column :ev_stations, :uuid, :string, default:""
  end
end
