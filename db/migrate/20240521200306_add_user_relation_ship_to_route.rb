class AddUserRelationShipToRoute < ActiveRecord::Migration[7.1]
  def change
    def up
      # Create routes table if it doesn't exist
      create_table :routes do |t|
        t.integer "energy_used"
        t.decimal "latitude_start", precision: 10, scale: 7
        t.decimal "longitude_start", precision: 10, scale: 7
        t.decimal "latitude_end", precision: 10, scale: 7
        t.decimal "longitude_end", precision: 10, scale: 7
        t.datetime "start_time"
        t.datetime "end_time"
        t.boolean "is_finished"
        t.float "distance"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        # ... other columns (if needed)
      end unless table_exists?(:routes)  # Check for existing table
  
      # Add foreign key reference to user
      add_reference :routes, :user, foreign_key: { to_table: :users }
    end
  
    def down
      # Remove foreign key reference
      remove_reference :routes, :user
  
      # Drop routes table (optional)
      drop_table :routes
    end
  end
end
