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

ActiveRecord::Schema.define(version: 2018_08_07_153114) do

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

  create_table "matches", force: :cascade do |t|
    t.integer "team_one_id", null: false
    t.integer "team_two_id", null: false
    t.integer "team_one_score", default: 0, null: false
    t.integer "team_two_score", default: 0, null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "duration", default: 720, null: false
    t.index ["team_one_id"], name: "index_matches_on_team_one_id"
    t.index ["team_two_id"], name: "index_matches_on_team_two_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.bigint "enrollment_id"
    t.integer "status", default: 2
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
    t.string "name", null: false
    t.text "description"
    t.string "logo"
    t.integer "player_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "timers" because of following StandardError
#   Unknown type 'timers_status' for column 'status'

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
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
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
    t.string "stripe_customer_id", limit: 51
  end

  add_foreign_key "enrollments", "teams"
  add_foreign_key "enrollments", "tournaments"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "registrations", "enrollments"
  add_foreign_key "registrations", "teams"
  add_foreign_key "registrations", "users"
  add_foreign_key "rosters", "teams"
  add_foreign_key "rosters", "users", column: "player_id"
  add_foreign_key "timers", "matches"
  add_foreign_key "tournament_staffs", "tournaments"
  add_foreign_key "tournament_staffs", "users"
end
