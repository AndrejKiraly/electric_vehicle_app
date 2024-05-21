class CreateRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :routes do |t|
      
      t.integer :energy_used
      t.decimal :latitude_start, precision: 10, scale: 7
      t.decimal :longitude_start, precision: 10, scale: 7
      t.decimal :latitude_end, precision: 10, scale: 7
      t.decimal :longitude_end, precision: 10, scale: 7
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :is_finished
      t.float :distance
      

      t.timestamps
    end
  end
end
