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

ActiveRecord::Schema.define(version: 2021_05_04_001021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enum_timestamps", force: :cascade do |t|
    t.integer "model_id", null: false
    t.string "model_type", null: false
    t.string "field_name", null: false
    t.integer "identifier", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_name", "identifier"], name: "index_enum_timestamps_on_field_name_and_identifier"
    t.index ["field_name"], name: "index_enum_timestamps_on_field_name"
    t.index ["identifier"], name: "index_enum_timestamps_on_identifier"
    t.index ["model_id", "model_type", "field_name", "identifier"], name: "enum_timestamps_unique_index", unique: true
    t.index ["model_id", "model_type"], name: "index_enum_timestamps_on_model_id_and_model_type"
  end

  create_table "users", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_users_on_status"
  end

end
