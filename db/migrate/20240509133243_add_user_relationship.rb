class AddUserRelationship < ActiveRecord::Migration[7.1]
  def change

    add_reference :ev_stations, :created_by, foreign_key: { to_table: :users }
    add_reference :ev_stations, :updated_by, foreign_key: { to_table: :users }
    add_reference :connections, :created_by, foreign_key: { to_table: :users }
    add_reference :connections, :updated_by, foreign_key: { to_table: :users }
  end
end
