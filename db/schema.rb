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

ActiveRecord::Schema[8.0].define(version: 2025_01_08_160532) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.integer "child_id", null: false
    t.integer "caregiver_id", null: false
    t.integer "activity_type", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.boolean "milestone", default: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caregiver_id"], name: "index_activities_on_caregiver_id"
    t.index ["child_id"], name: "index_activities_on_child_id"
    t.index ["start_time"], name: "index_activities_on_start_time"
  end

  create_table "caregivers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_caregivers_on_email", unique: true
  end

  create_table "children", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.date "birth_date", null: false
    t.decimal "birth_weight_value", precision: 5, scale: 2
    t.string "birth_weight_unit", default: "kg", null: false
    t.decimal "birth_length_value", precision: 5, scale: 2
    t.string "birth_length_unit", default: "cm", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "children_caregivers", force: :cascade do |t|
    t.integer "child_id", null: false
    t.integer "caregiver_id", null: false
    t.string "relationship"
    t.index ["caregiver_id"], name: "index_children_caregivers_on_caregiver_id"
    t.index ["child_id", "caregiver_id"], name: "index_children_caregivers_on_child_id_and_caregiver_id", unique: true
    t.index ["child_id"], name: "index_children_caregivers_on_child_id"
  end

  create_table "diaper_changes", force: :cascade do |t|
    t.integer "child_id", null: false
    t.integer "caregiver_id", null: false
    t.datetime "time", null: false
    t.integer "change_type", null: false
    t.integer "color"
    t.integer "consistency"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caregiver_id"], name: "index_diaper_changes_on_caregiver_id"
    t.index ["child_id"], name: "index_diaper_changes_on_child_id"
    t.index ["time"], name: "index_diaper_changes_on_time"
  end

  create_table "feedings", force: :cascade do |t|
    t.integer "child_id", null: false
    t.integer "caregiver_id", null: false
    t.integer "feeding_type", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.integer "side"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "volume_value", precision: 10, scale: 2
    t.string "volume_unit", limit: 12
    t.decimal "weight_value", precision: 10, scale: 2
    t.string "weight_unit", limit: 12
    t.index ["caregiver_id"], name: "index_feedings_on_caregiver_id"
    t.index ["child_id"], name: "index_feedings_on_child_id"
    t.index ["start_time"], name: "index_feedings_on_start_time"
  end

  create_table "measurements", force: :cascade do |t|
    t.integer "child_id", null: false
    t.integer "caregiver_id", null: false
    t.date "date", null: false
    t.decimal "weight_value", precision: 10, scale: 3
    t.string "weight_unit"
    t.decimal "length_value", precision: 10, scale: 2
    t.string "length_unit"
    t.decimal "head_circumference_value", precision: 10, scale: 2
    t.string "head_circumference_unit"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caregiver_id"], name: "index_measurements_on_caregiver_id"
    t.index ["child_id"], name: "index_measurements_on_child_id"
  end

  create_table "sleep_sessions", force: :cascade do |t|
    t.integer "child_id", null: false
    t.integer "caregiver_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.integer "location"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caregiver_id"], name: "index_sleep_sessions_on_caregiver_id"
    t.index ["child_id"], name: "index_sleep_sessions_on_child_id"
    t.index ["start_time"], name: "index_sleep_sessions_on_start_time"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "caregivers"
  add_foreign_key "activities", "children"
  add_foreign_key "children_caregivers", "caregivers"
  add_foreign_key "children_caregivers", "children"
  add_foreign_key "diaper_changes", "caregivers"
  add_foreign_key "diaper_changes", "children"
  add_foreign_key "feedings", "caregivers"
  add_foreign_key "feedings", "children"
  add_foreign_key "measurements", "caregivers"
  add_foreign_key "measurements", "children"
  add_foreign_key "sleep_sessions", "caregivers"
  add_foreign_key "sleep_sessions", "children"
end
