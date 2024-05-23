class ChangeCountryString < ActiveRecord::Migration[7.1]
  def change
    rename_column :ev_stations, :country, :country_string
    add_reference :ev_stations, :country, foreign_key: true
    
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
