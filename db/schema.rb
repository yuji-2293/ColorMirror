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

ActiveRecord::Schema[8.0].define(version: 2025_01_19_063924) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "analysis_results", force: :cascade do |t|
    t.bigint "response_id", null: false
    t.string "analysis_value"
    t.string "analysis_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["response_id"], name: "index_analysis_results_on_response_id"
  end

  create_table "colors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "color_name", null: false
    t.bigint "mood_level"
    t.datetime "selected_at"
  end

  create_table "reminders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "description", null: false
    t.datetime "remind_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reminders_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "self_log_id", null: false
    t.string "ai_comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["self_log_id"], name: "index_responses_on_self_log_id"
  end

  create_table "self_logs", force: :cascade do |t|
    t.bigint "color_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_id"], name: "index_self_logs_on_color_id"
    t.index ["user_id"], name: "index_self_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "provider"
    t.integer "uid"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "whether_logs", force: :cascade do |t|
    t.bigint "self_log_id", null: false
    t.datetime "fetched_at"
    t.integer "whether_pressure"
    t.string "whether_condition"
    t.integer "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["self_log_id"], name: "index_whether_logs_on_self_log_id"
  end

  add_foreign_key "analysis_results", "responses"
  add_foreign_key "reminders", "users"
  add_foreign_key "responses", "self_logs"
  add_foreign_key "self_logs", "colors"
  add_foreign_key "self_logs", "users"
  add_foreign_key "whether_logs", "self_logs"
end
