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

ActiveRecord::Schema.define(version: 2018_06_28_032752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "enrollments", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_enrollments_on_team_id"
    t.index ["tournament_id"], name: "index_enrollments_on_tournament_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.bigint "enrollment_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id"], name: "index_registrations_on_enrollment_id"
    t.index ["team_id"], name: "index_registrations_on_team_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "rosters", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "team_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_rosters_on_player_id"
    t.index ["team_id"], name: "index_rosters_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "logo"
    t.integer "player_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournament_staffs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tournament_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_tournament_staffs_on_tournament_id"
    t.index ["user_id"], name: "index_tournament_staffs_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "registration_start_date"
    t.datetime "registration_end_date"
    t.text "description"
    t.integer "team_cap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first"
    t.string "last"
    t.string "nickname"
    t.string "dob"
    t.string "phone"
    t.string "gender"
    t.string "email"
    t.text "bio"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "enrollments", "teams"
  add_foreign_key "enrollments", "tournaments"
  add_foreign_key "registrations", "enrollments"
  add_foreign_key "registrations", "teams"
  add_foreign_key "registrations", "users"
  add_foreign_key "rosters", "teams"
  add_foreign_key "rosters", "users", column: "player_id"
  add_foreign_key "tournament_staffs", "tournaments"
  add_foreign_key "tournament_staffs", "users"
end
