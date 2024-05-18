class CreateCurrentTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :current_types, id: false do |t|
      t.integer :id, primary_key: true
      t.string :description
      t.string :title

      t.timestamps
    end
  end
end
