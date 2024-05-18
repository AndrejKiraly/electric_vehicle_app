class AddConnectionTypeToConnection < ActiveRecord::Migration[7.1]
  def change
    add_reference :connections, :connection_type, foreign_key: true
  end
end
