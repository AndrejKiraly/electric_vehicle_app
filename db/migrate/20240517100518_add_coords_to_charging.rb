class AddCoordsToCharging < ActiveRecord::Migration[7.1]
  def change
    add_column :chargings, :latitude, :decimal, precision: 10, scale: 7
    add_column :chargings, :longitude, :decimal, precision: 10, scale: 7
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
