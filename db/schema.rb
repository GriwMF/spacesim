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

ActiveRecord::Schema.define(version: 2018_10_29_070709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "celestial_objects", force: :cascade do |t|
    t.bigint "parent_object_id"
    t.string "name"
    t.integer "type"
    t.integer "altitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_object_id"], name: "index_celestial_objects_on_parent_object_id"
  end

  create_table "solar_systems", force: :cascade do |t|
    t.string "name"
    t.integer "x"
    t.integer "y"
    t.integer "z"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "celestial_object_id"
    t.index ["celestial_object_id"], name: "index_solar_systems_on_celestial_object_id"
  end

  add_foreign_key "celestial_objects", "celestial_objects", column: "parent_object_id"
  add_foreign_key "solar_systems", "celestial_objects"
end
