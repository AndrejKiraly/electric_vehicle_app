class CreateEvStations < ActiveRecord::Migration[7.1]
  def change
    create_table :ev_stations do |t|
      t.decimal "latitude", precision: 10, scale: 7
      t.decimal "longitude", precision: 10, scale: 7

      t.string "name", default: ""
      t.string "address_line", default: ""
      t.string "city", default: ""
      t.string "country", default: ""
      t.string "post_code", default: ""
      t.string "uuid"
      t.string "source", default: ""
      t.string "phone_number", default: ""
      t.string "email", default: ""
      t.string "operator_website_url", default: ""

      t.float "rating", default: 0.0 
      t.integer "user_rating_total", default: 0
      t.boolean "is_membership_required"
      t.boolean "is_access_key_required"
      t.boolean "is_pay_at_location"

      

      t.boolean "is_free", default: false #nie
      t.string "open_hours", default: "" #nie
     
      t.string "access_type_title", default: "" #nvm
      t.string "access_comments", default: "" #nvm
      t.string "energy_source", default: ""
      t.string "limit_time", default: "" #nie
      t.text "instruction_for_user", default: "" #nie
      t.string "price_information", default: ""

      
   
      t.timestamps
    end
  end
end
