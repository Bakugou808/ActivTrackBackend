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

ActiveRecord::Schema.define(version: 2020_10_10_215550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "circuit_exercise_session_details", force: :cascade do |t|
    t.bigint "session_id", null: false
    t.bigint "circuit_exercise_id", null: false
    t.string "stats"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circuit_exercise_id"], name: "index_circuit_exercise_session_details_on_circuit_exercise_id"
    t.index ["session_id"], name: "index_circuit_exercise_session_details_on_session_id"
  end

  create_table "circuit_exercises", force: :cascade do |t|
    t.bigint "circuit_id", null: false
    t.bigint "exercise_id", null: false
    t.integer "position"
    t.string "ex_attributes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circuit_id"], name: "index_circuit_exercises_on_circuit_id"
    t.index ["exercise_id"], name: "index_circuit_exercises_on_exercise_id"
  end

  create_table "circuits", force: :cascade do |t|
    t.string "phase"
    t.integer "position"
    t.string "circuit_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "exercise_name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "folder_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.integer "count"
    t.string "active_time"
    t.string "rest_time"
    t.string "total_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workout_id"], name: "index_sessions_on_workout_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workout_circuits", force: :cascade do |t|
    t.bigint "workout_id", null: false
    t.bigint "circuit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circuit_id"], name: "index_workout_circuits_on_circuit_id"
    t.index ["workout_id"], name: "index_workout_circuits_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "folder_id", null: false
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["folder_id"], name: "index_workouts_on_folder_id"
  end

  add_foreign_key "circuit_exercise_session_details", "circuit_exercises"
  add_foreign_key "circuit_exercise_session_details", "sessions"
  add_foreign_key "circuit_exercises", "circuits"
  add_foreign_key "circuit_exercises", "exercises"
  add_foreign_key "folders", "users"
  add_foreign_key "sessions", "workouts"
  add_foreign_key "workout_circuits", "circuits"
  add_foreign_key "workout_circuits", "workouts"
  add_foreign_key "workouts", "folders"
end
