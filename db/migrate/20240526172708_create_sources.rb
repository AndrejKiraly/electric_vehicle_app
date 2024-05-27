class CreateSources < ActiveRecord::Migration[7.1]
  def change
    create_table :sources, id: false do |t|
      t.integer :id, primary_key: true
      t.string :title

      t.timestamps
    end
  end
end
