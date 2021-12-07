# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_16_175626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_tables", force: :cascade do |t|
    t.string "action_type"
    t.bigint "ship_id"
    t.json "parsed_params"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ship_id"], name: "index_action_tables_on_ship_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.string "locale"
    t.text "text"
    t.boolean "published"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "facility_todo_id"
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
    t.index ["facility_todo_id"], name: "index_characters_on_facility_todo_id"
    t.index ["location_type", "location_id"], name: "index_characters_on_location_type_and_location_id"
  end

  create_table "facilities_systems", force: :cascade do |t|
    t.bigint "ship_id"
    t.string "type"
    t.integer "power", default: 0
    t.integer "priority", default: 0
    t.integer "max_power", default: 0
    t.integer "oxygen", default: 0
    t.integer "max_oxygen", default: 0
    t.integer "temp", default: 20
    t.decimal "integrity", default: "10.0"
    t.integer "humidity", default: 60
    t.integer "max_production"
    t.integer "consumption"
    t.json "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priority", "ship_id", "type"], name: "index_facilities_systems_on_priority_and_ship_id_and_type"
    t.index ["ship_id"], name: "index_facilities_systems_on_ship_id"
  end

  create_table "facility_todos", force: :cascade do |t|
    t.bigint "facilities_system_id"
    t.integer "role", limit: 2
    t.integer "required_personell_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["facilities_system_id"], name: "index_facility_todos_on_facilities_system_id"
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
    t.bigint "ship_id"
    t.text "action"
    t.boolean "notify"
    t.json "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_histories_on_object_type_and_object_id"
    t.index ["ship_id"], name: "index_histories_on_ship_id"
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
    t.string "name"
    t.decimal "position_x"
    t.decimal "position_y"
    t.decimal "position_z"
    t.decimal "integrity", default: "100.0"
    t.integer "progress", limit: 2, default: 0, null: false
    t.integer "bonus_speed", default: 0, null: false
    t.integer "speed"
    t.integer "storage"
    t.boolean "fly"
    t.boolean "killed", default: false, null: false
    t.boolean "alarm"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "password_digest"
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

  add_foreign_key "action_tables", "ships"
  add_foreign_key "characters", "facility_todos"
  add_foreign_key "facilities_systems", "ships"
  add_foreign_key "facility_todos", "facilities_systems"
  add_foreign_key "factories", "celestial_objects"
  add_foreign_key "histories", "ships"
  add_foreign_key "productions", "factories"
  add_foreign_key "productions", "materials"
  add_foreign_key "skills", "characters"
  add_foreign_key "stocks", "materials"
end
