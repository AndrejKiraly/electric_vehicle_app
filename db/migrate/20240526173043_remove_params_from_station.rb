class RemoveParamsFromStation < ActiveRecord::Migration[7.1]
  def change
    remove_column :ev_stations, :source, :string, default: ""
    remove_column :ev_stations, :is_membership_required, :boolean
    remove_column :ev_stations, :is_access_key_required, :boolean
    remove_column :ev_stations, :is_pay_at_location, :boolean
    remove_column :ev_stations, :access_type_title, :string, default: ""
    remove_column :ev_stations, :access_comments, :string, default: ""
    remove_column :ev_stations, :energy_source, :string, default: ""
    remove_column :ev_stations, :limit_time, :string, default: ""
  end
end


