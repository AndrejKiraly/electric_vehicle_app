class CreateConnectionTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :connection_types, id: false do |t|
      t.integer :id, primary_key: true
      t.string :formal_name
      t.boolean :is_discontinued
      t.boolean :is_obsolete
      t.string :title

      t.timestamps
    end
  end
end
