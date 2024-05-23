class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries, id: false do |t|
      t.integer :id, primary_key: true
      t.string :iso_code
      t.string :continent_code
      t.string :title

      t.timestamps
    end
  end
end
