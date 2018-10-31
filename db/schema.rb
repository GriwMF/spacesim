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

ActiveRecord::Schema.define(version: 2018_10_30_055128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "celestial_objects", force: :cascade do |t|
    t.bigint "parent_object_id"
    t.string "name"
    t.integer "altitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_object_id"], name: "index_celestial_objects_on_parent_object_id"
  end

  create_table "factories", force: :cascade do |t|
    t.string "name"
    t.integer "step_progress", limit: 2
    t.integer "altitude"
    t.integer "progress", limit: 2, default: 0, null: false
    t.bigint "celestial_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["celestial_object_id"], name: "index_factories_on_celestial_object_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.integer "weigth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "productions", force: :cascade do |t|
    t.bigint "material_id"
    t.bigint "factory_id"
    t.boolean "is_output", default: false, null: false
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["factory_id"], name: "index_productions_on_factory_id"
    t.index ["material_id"], name: "index_productions_on_material_id"
  end

  create_table "ships", force: :cascade do |t|
    t.integer "hp"
    t.string "name"
    t.bigint "solar_system_id"
    t.bigint "celestial_object_id"
    t.integer "progress", limit: 2, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["celestial_object_id"], name: "index_ships_on_celestial_object_id"
    t.index ["solar_system_id"], name: "index_ships_on_solar_system_id"
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

  create_table "stocks", force: :cascade do |t|
    t.bigint "material_id"
    t.string "object_type"
    t.bigint "object_id"
    t.integer "amount", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_stocks_on_material_id"
    t.index ["object_type", "object_id"], name: "index_stocks_on_object_type_and_object_id"
  end

  add_foreign_key "celestial_objects", "celestial_objects", column: "parent_object_id"
  add_foreign_key "factories", "celestial_objects"
  add_foreign_key "productions", "factories"
  add_foreign_key "productions", "materials"
  add_foreign_key "ships", "celestial_objects"
  add_foreign_key "ships", "solar_systems"
  add_foreign_key "solar_systems", "celestial_objects"
  add_foreign_key "stocks", "materials"
end
