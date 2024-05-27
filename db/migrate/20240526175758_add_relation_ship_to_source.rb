class AddRelationShipToSource < ActiveRecord::Migration[7.1]
  def change
    add_reference :ev_stations, :source, foreign_key: true
  end
end
