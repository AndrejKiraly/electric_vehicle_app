class CreateChargings < ActiveRecord::Migration[7.1]
  def change
    create_table :chargings do |t|
      # Foreign key relationship with users table
      t.belongs_to :user, index: true, foreign_key: true

      # String for vehicle identification
      t.string :vehicle_id, null: false

      # Foreign key relationship with ev_stations table
      #t.belongs_to :ev_station, index: true, foreign_key: true
      t.belongs_to :connection, index: true, foreign_key: true

      # Battery level information
      t.integer :battery_level_start, null: false
      t.integer :battery_level_end, null: true

      # Charging cost information
      t.float :price, default: 0.0

      # Energy usage information
      t.integer :energy_used, default: 0

      # User rating for the charging experience
      t.integer :rating, default: 0

      # Optional comment for the charging session
      t.string :comment, default: ""
      
      # Date and time of charging session start
      t.datetime :start_time, null: false

      # Date and time of charging session end (nullable)
      t.datetime :end_time, null: true

      t.boolean :is_finished, default: false

      t.timestamps
    end
  end
end


# add_reference :chargings, :created_by, foreign_key: { to_table: :users }
      # add_reference :chargings, :ev_station_id, foreign_key: { to_table: :ev_stations }
      # add_column :chargings, :vehicle_id, :string
      # add_column :chargings, :start_time, :datetime
      # add_column :chargings, :end_time, :datetime
      # add_column  :chargings, :battery_level_start, :integer
      # add_column :chargings, :battery_level_end, :integer
      # add_column :chargings, :price, :decimal, default: 0.0
      # add_column :chargings, :energy_used, :decimal, default: 0.0
      # add_column :chargings, :rating, :integer, default: 0
      # add_column :chargings, :comment, :text, default: ""