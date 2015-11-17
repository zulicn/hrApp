# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151115135413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "event_attendences", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "event_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name",        null: false
    t.text   "description"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "is_chargeable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                default: true
    t.boolean  "should_record_attendence", default: false
    t.integer  "event_type_id"
  end

  create_table "guests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id",    null: false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_teams", force: :cascade do |t|
    t.integer "project_id"
    t.integer "team_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",                       null: false
    t.string   "description",                null: false
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "is_active",   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",              null: false
    t.text     "description",       null: false
    t.integer  "num_of_members"
    t.date     "deadline_to_apply"
    t.date     "deadline"
    t.text     "note"
    t.text     "report"
    t.integer  "creator_id",        null: false
    t.integer  "project_team_id"
    t.integer  "team_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "shortcode",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.text     "admin_report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "role_id",                             null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "email"
    t.string   "phone"
    t.integer  "department_id",                       null: false
    t.string   "password_digest"
    t.date     "birth_date"
    t.string   "place_of_birth"
    t.text     "previous_experience"
    t.text     "reason_of_enrollment"
    t.text     "additional_skills"
    t.boolean  "is_accepted",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  create_table "welcomes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workshops", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "lc"
    t.datetime "start_date"
    t.datetime "end_date"
  end

end
