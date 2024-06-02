# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_01_173204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "amenities", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities_ev_stations", id: false, force: :cascade do |t|
    t.bigint "ev_station_id", null: false
    t.bigint "amenity_id", null: false
    t.index ["amenity_id", "ev_station_id"], name: "index_amenities_ev_stations_on_amenity_id_and_ev_station_id"
    t.index ["ev_station_id", "amenity_id"], name: "index_amenities_ev_stations_on_ev_station_id_and_amenity_id"
  end

  create_table "chargings", force: :cascade do |t|
    t.bigint "user_id"
    t.string "vehicle_id", null: false
    t.bigint "connection_id"
    t.integer "battery_level_start", null: false
    t.integer "battery_level_end"
    t.float "price", default: 0.0
    t.integer "energy_used", default: 0
    t.integer "rating", default: 0
    t.string "comment", default: ""
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.boolean "is_finished", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geography "coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.bigint "vehicle_route_id"
    t.index ["connection_id"], name: "index_chargings_on_connection_id"
    t.index ["coordinates"], name: "index_chargings_on_coordinates", using: :gist
    t.index ["user_id"], name: "index_chargings_on_user_id"
    t.index ["vehicle_route_id"], name: "index_chargings_on_vehicle_route_id"
  end

  create_table "connection_types", id: :serial, force: :cascade do |t|
    t.string "formal_name"
    t.boolean "is_discontinued"
    t.boolean "is_obsolete"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "ev_station_id", null: false
    t.boolean "is_operational_status", default: true
    t.boolean "is_fast_charge_capable", default: false
    t.integer "amps", default: 0
    t.integer "voltage", default: 0
    t.integer "power_kw", default: 0
    t.integer "quantity", default: 0
    t.string "charging_level", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.bigint "connection_type_id"
    t.bigint "current_type_id"
    t.index ["connection_type_id"], name: "index_connections_on_connection_type_id"
    t.index ["created_by_id"], name: "index_connections_on_created_by_id"
    t.index ["current_type_id"], name: "index_connections_on_current_type_id"
    t.index ["ev_station_id"], name: "index_connections_on_ev_station_id"
    t.index ["updated_by_id"], name: "index_connections_on_updated_by_id"
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "iso_code"
    t.string "continent_code"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "current_types", id: :serial, force: :cascade do |t|
    t.string "description"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devise_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_devise_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_devise_users_on_reset_password_token", unique: true
  end

  create_table "ev_stations", force: :cascade do |t|
    t.string "name", default: ""
    t.string "address_line", default: ""
    t.string "city", default: ""
    t.string "country_string", default: ""
    t.string "post_code", default: ""
    t.string "phone_number", default: ""
    t.string "email", default: ""
    t.string "operator_website_url", default: ""
    t.float "rating", default: 0.0
    t.integer "user_rating_total", default: 0
    t.boolean "is_free", default: false
    t.string "open_hours", default: ""
    t.text "instruction_for_user", default: ""
    t.string "price_information", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id"
    t.bigint "updated_by_id"
    t.bigint "usage_type_id"
    t.bigint "country_id"
    t.geography "coordinates", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.bigint "source_id"
    t.string "uuid", default: ""
    t.index ["coordinates"], name: "index_ev_stations_on_coordinates", using: :gist
    t.index ["country_id"], name: "index_ev_stations_on_country_id"
    t.index ["created_by_id"], name: "index_ev_stations_on_created_by_id"
    t.index ["source_id"], name: "index_ev_stations_on_source_id"
    t.index ["updated_by_id"], name: "index_ev_stations_on_updated_by_id"
    t.index ["usage_type_id"], name: "index_ev_stations_on_usage_type_id"
  end

  create_table "sources", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "station_admins", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_station_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_station_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_station_admins_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_station_admins_on_uid_and_provider", unique: true
  end

  create_table "usage_types", id: :serial, force: :cascade do |t|
    t.boolean "is_pay_at_location"
    t.boolean "is_membership_required"
    t.boolean "is_access_key_required"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "username"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "vehicle_routes", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.float "distance", default: 0.0
    t.float "energy_used", default: 0.0
    t.datetime "end_time"
    t.boolean "is_finished", default: false
    t.geography "polyline", limit: {:srid=>4326, :type=>"line_string", :geographic=>true}
    t.integer "battery_start"
    t.integer "battery_end"
    t.string "vehicle_id"
    t.index ["user_id"], name: "index_vehicle_routes_on_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.json "object"
    t.json "object_changes"
    t.integer "status", default: 0
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "chargings", "connections"
  add_foreign_key "chargings", "users"
  add_foreign_key "chargings", "vehicle_routes"
  add_foreign_key "connections", "connection_types"
  add_foreign_key "connections", "current_types"
  add_foreign_key "connections", "ev_stations"
  add_foreign_key "connections", "users", column: "created_by_id"
  add_foreign_key "connections", "users", column: "updated_by_id"
  add_foreign_key "ev_stations", "countries"
  add_foreign_key "ev_stations", "sources"
  add_foreign_key "ev_stations", "usage_types"
  add_foreign_key "ev_stations", "users", column: "created_by_id"
  add_foreign_key "ev_stations", "users", column: "updated_by_id"
  add_foreign_key "vehicle_routes", "users"
end
