class CreateConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :connections do |t|
      t.references :ev_station, null: false, foreign_key: true
      t.boolean "is_operational_status", default: true
      t.boolean "is_fast_charge_capable", default: false
      t.integer "amps", default: 0
      t.integer "voltage", default: 0
      t.integer "power_kw", default: 0
      t.integer "quantity", default: 0
      t.string "charging_level", default: ""
      t.string "current_type", default: ""
      t.string "connection_type", default: ""

     

      t.timestamps
    end
  end
end
