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

ActiveRecord::Schema[7.0].define(version: 2023_03_03_070425) do
  create_table "main_pets", force: :cascade do |t|
    t.string "name"
    t.string "animal_type"
    t.string "breed"
    t.string "age"
    t.string "size"
    t.string "gender"
    t.string "description"
    t.string "photo_url"
    t.string "api_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "idx_api_id", unique: true
  end

  

  create_table "pet_owners", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pet_id", null: false
    t.string "api_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_pet_owners_on_pet_id"
    t.index ["user_id"], name: "index_pet_owners_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "uk_email", unique: true
  end

  add_foreign_key "pet_owners", "pets"
  add_foreign_key "pet_owners", "users"
end
