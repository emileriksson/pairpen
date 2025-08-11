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

ActiveRecord::Schema[8.0].define(version: 2025_08_11_184705) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.string "email", null: false
    t.text "application_text", null: false
    t.string "status", default: "unverified", null: false
    t.string "verification_token", null: false
    t.string "status_token", null: false
    t.datetime "verified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_applications_on_email"
    t.index ["status"], name: "index_applications_on_status"
    t.index ["status_token"], name: "index_applications_on_status_token", unique: true
    t.index ["verification_token"], name: "index_applications_on_verification_token", unique: true
  end

  create_table "email_templates", force: :cascade do |t|
    t.string "name", null: false
    t.string "subject", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_email_templates_on_name", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "application_one_id", null: false
    t.bigint "application_two_id", null: false
    t.bigint "admin_id", null: false
    t.datetime "matched_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_matches_on_admin_id"
    t.index ["application_one_id", "application_two_id"], name: "index_matches_on_application_one_id_and_application_two_id", unique: true
    t.index ["application_one_id"], name: "index_matches_on_application_one_id"
    t.index ["application_two_id"], name: "index_matches_on_application_two_id"
    t.index ["matched_at"], name: "index_matches_on_matched_at"
  end

  add_foreign_key "matches", "admins"
  add_foreign_key "matches", "applications", column: "application_one_id"
  add_foreign_key "matches", "applications", column: "application_two_id"
end
