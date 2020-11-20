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

ActiveRecord::Schema.define(version: 2020_11_16_225405) do

  create_table "assists", force: :cascade do |t|
    t.integer "goal_id"
    t.integer "player_id"
  end

  create_table "game_players", force: :cascade do |t|
    t.integer "game_id"
    t.integer "player_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "season_id"
    t.string "opponent"
    t.string "status"
    t.string "win_loss"
    t.string "place"
    t.datetime "game_datetime"
  end

  create_table "goals", force: :cascade do |t|
    t.integer "game_id"
    t.integer "player_id"
    t.integer "team_id"
    t.integer "period"
    t.string "time_scored"
  end

  create_table "on_ice_for_goal", force: :cascade do |t|
    t.integer "goal_id"
    t.integer "player_id"
  end

  create_table "penalties", force: :cascade do |t|
    t.integer "game_id"
    t.integer "player_id"
    t.integer "team_id"
    t.integer "period"
    t.string "time_committed"
    t.integer "length"
    t.string "infraction"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "team_id"
    t.integer "user_id"
    t.string "position"
    t.integer "jersey_num"
    t.string "status"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.integer "team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id"
    t.integer "current_season_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
  end

end
