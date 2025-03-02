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

ActiveRecord::Schema[8.0].define(version: 2025_03_02_143100) do
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
    t.string "color_name", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color_analysis"
    t.string "weather_analysis"
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
    t.integer "prefecture"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weather_logs", force: :cascade do |t|
    t.bigint "self_log_id", null: false
    t.integer "weather_pressure"
    t.string "weather_name"
    t.integer "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "temp_max"
    t.integer "temp_min"
    t.string "weather_icon"
    t.string "description"
    t.string "city"
    t.index ["self_log_id"], name: "index_weather_logs_on_self_log_id"
  end

  add_foreign_key "analysis_results", "responses"
  add_foreign_key "reminders", "users"
  add_foreign_key "responses", "self_logs"
  add_foreign_key "self_logs", "colors"
  add_foreign_key "self_logs", "users"
  add_foreign_key "weather_logs", "self_logs"
end
