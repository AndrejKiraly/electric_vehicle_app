class AddCurrentTypeToConnection < ActiveRecord::Migration[7.1]
  def change
    remove_column :connections, :current_type, :string
    add_reference :connections, :current_type, foreign_key: true
    
  end
end
