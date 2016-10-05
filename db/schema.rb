# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161001025029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "destinations", force: :cascade do |t|
    t.integer  "distance"
    t.string   "distance_text"
    t.integer  "duration"
    t.string   "duration_text"
    t.integer  "origin_id"
    t.string   "origin_type"
    t.string   "origin_address"
    t.string   "address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["origin_type", "origin_id"], name: "index_destinations_on_origin_type_and_origin_id", using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "station_name"
    t.integer  "available_docks"
    t.integer  "total_docks"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "status_value"
    t.integer  "status_key"
    t.string   "status"
    t.integer  "available_bikes"
    t.string   "st_address1"
    t.string   "st_address2"
    t.string   "city"
    t.string   "postal_code"
    t.string   "location"
    t.string   "altitude"
    t.boolean  "test_station"
    t.datetime "last_communication_time"
    t.string   "land_mark"
    t.boolean  "is_renting"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
