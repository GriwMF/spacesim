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

ActiveRecord::Schema.define(version: 2018_12_11_155907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bays", force: :cascade do |t|
    t.bigint "ship_id"
    t.integer "power", default: 0
    t.integer "max_power", default: 0
    t.integer "oxygen", default: 0
    t.integer "max_oxygen", default: 0
    t.integer "temp", default: 20
    t.integer "integrity", default: 100
    t.integer "humidity", default: 60
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "control"
    t.index ["ship_id"], name: "index_bays_on_ship_id"
  end

  create_table "celestial_objects", force: :cascade do |t|
    t.string "name"
    t.decimal "position_x"
    t.decimal "position_y"
    t.decimal "position_z"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "role", limit: 2
    t.string "base_type"
    t.bigint "base_id"
    t.string "location_type"
    t.bigint "location_id"
    t.integer "hp", default: 100, null: false
    t.integer "hunger", default: 0, null: false
    t.integer "fatigue", default: 0, null: false
    t.integer "skill", default: 0, null: false
    t.integer "skip", default: 0, null: false
    t.integer "skip_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_type", "base_id"], name: "index_characters_on_base_type_and_base_id"
    t.index ["location_type", "location_id"], name: "index_characters_on_location_type_and_location_id"
  end

  create_table "facilities_systems", force: :cascade do |t|
    t.string "type"
    t.integer "durability"
    t.integer "max_production"
    t.integer "consumption"
    t.bigint "bay_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bay_id"], name: "index_facilities_systems_on_bay_id"
  end

  create_table "factories", force: :cascade do |t|
    t.string "name"
    t.integer "speed", limit: 2
    t.integer "altitude"
    t.integer "progress", limit: 2, default: 0, null: false
    t.integer "storage"
    t.bigint "celestial_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["celestial_object_id"], name: "index_factories_on_celestial_object_id"
  end

  create_table "histories", force: :cascade do |t|
    t.string "object_type"
    t.bigint "object_id"
    t.string "target_type"
    t.bigint "target_id"
    t.text "action"
    t.json "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_histories_on_object_type_and_object_id"
    t.index ["target_type", "target_id"], name: "index_histories_on_target_type_and_target_id"
  end

  create_table "mailkick_opt_outs", force: :cascade do |t|
    t.string "email"
    t.string "user_type"
    t.bigint "user_id"
    t.boolean "active", default: true, null: false
    t.string "reason"
    t.string "list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mailkick_opt_outs_on_email"
    t.index ["user_type", "user_id"], name: "index_mailkick_opt_outs_on_user_type_and_user_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.integer "weigth"
    t.integer "base_price"
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
    t.decimal "position_x"
    t.decimal "position_y"
    t.decimal "position_z"
    t.bigint "production_id"
    t.string "target_type"
    t.bigint "target_id"
    t.integer "action", limit: 2
    t.integer "progress", limit: 2, default: 0, null: false
    t.integer "bonus_speed", default: 0, null: false
    t.integer "speed"
    t.integer "storage"
    t.integer "energy"
    t.integer "o2"
    t.boolean "fly"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["production_id"], name: "index_ships_on_production_id"
    t.index ["target_type", "target_id"], name: "index_ships_on_target_type_and_target_id"
  end

  create_table "skills", force: :cascade do |t|
    t.bigint "character_id"
    t.integer "skill", null: false
    t.integer "value", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_skills_on_character_id"
    t.index ["skill", "character_id"], name: "index_skills_on_skill_and_character_id", unique: true
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

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "locale", default: "en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "world_data", force: :cascade do |t|
    t.string "key"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bays", "ships"
  add_foreign_key "facilities_systems", "bays"
  add_foreign_key "factories", "celestial_objects"
  add_foreign_key "productions", "factories"
  add_foreign_key "productions", "materials"
  add_foreign_key "ships", "productions"
  add_foreign_key "skills", "characters"
  add_foreign_key "stocks", "materials"
end
