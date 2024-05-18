class CreateUsageTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :usage_types, id: false do |t|
      t.integer :id, primary_key: true
      t.boolean :is_pay_at_location
      t.boolean :is_membership_required
      t.boolean :is_access_key_required
      t.string :title

      t.timestamps
    end
  end
end
