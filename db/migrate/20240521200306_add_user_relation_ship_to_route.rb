class AddUserRelationShipToRoute < ActiveRecord::Migration[7.1]
  def change
    add_reference :routes, :user, foreign_key: { to_table: :users }
  end
end
