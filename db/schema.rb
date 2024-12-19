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

ActiveRecord::Schema[7.1].define(version: 2024_12_18_135629) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "survey_participants", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "corporate_email", default: "", null: false
    t.string "department", default: "", null: false
    t.string "position", default: "", null: false
    t.string "function", default: "", null: false
    t.string "location", default: "", null: false
    t.string "company_tenure", default: "", null: false
    t.string "gender", default: "", null: false
    t.string "generation", default: "", null: false
    t.string "lv0_company", default: "", null: false
    t.string "lv1_directorate", default: "", null: false
    t.string "lv2_management", default: "", null: false
    t.string "lv3_coordination", default: "", null: false
    t.string "lv4_area", default: "", null: false
    t.bigint "survey_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_participants_on_survey_id"
  end

  create_table "survey_polls", force: :cascade do |t|
    t.string "title", default: ""
    t.text "description", default: ""
    t.bigint "survey_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_polls_on_survey_id"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.text "prompt", default: "", null: false
    t.string "kind", default: "", null: false
    t.bigint "survey_poll_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_poll_id"], name: "index_survey_questions_on_survey_poll_id"
  end

  create_table "survey_responses", force: :cascade do |t|
    t.string "answer", default: "", null: false
    t.text "comment", default: ""
    t.datetime "answered_at"
    t.bigint "survey_question_id", null: false
    t.bigint "survey_participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_participant_id"], name: "index_survey_responses_on_survey_participant_id"
    t.index ["survey_question_id"], name: "index_survey_responses_on_survey_question_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.string "description", default: "", null: false
    t.string "status", default: "drafted", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "survey_participants", "surveys"
  add_foreign_key "survey_polls", "surveys"
  add_foreign_key "survey_questions", "survey_polls"
  add_foreign_key "survey_responses", "survey_participants"
  add_foreign_key "survey_responses", "survey_questions"
end
