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

ActiveRecord::Schema.define(version: 20131107152641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applies", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applies", ["team_id", "user_id"], name: "index_applies_on_team_id_and_user_id", unique: true, using: :btree
  add_index "applies", ["team_id"], name: "index_applies_on_team_id", using: :btree
  add_index "applies", ["user_id"], name: "index_applies_on_user_id", using: :btree

  create_table "docs", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doc_file_file_name"
    t.string   "doc_file_content_type"
    t.integer  "doc_file_file_size"
    t.datetime "doc_file_updated_at"
  end

  add_index "docs", ["title"], name: "index_docs_on_title", using: :btree

  create_table "duels", force: true do |t|
    t.integer  "a_id"
    t.integer  "b_id"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  add_index "duels", ["a_id"], name: "index_duels_on_a_id", using: :btree
  add_index "duels", ["b_id"], name: "index_duels_on_b_id", using: :btree
  add_index "duels", ["event_id"], name: "index_duels_on_event_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.date     "due_date"
  end

  add_index "events", ["name"], name: "index_events_on_name", using: :btree

  create_table "informs", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["team_id", "user_id"], name: "index_invitations_on_team_id_and_user_id", unique: true, using: :btree
  add_index "invitations", ["team_id"], name: "index_invitations_on_team_id", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["team_id", "user_id"], name: "index_memberships_on_team_id_and_user_id", unique: true, using: :btree
  add_index "memberships", ["team_id"], name: "index_memberships_on_team_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "periods", force: true do |t|
    t.integer  "event_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_number", default: 0
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "replies", force: true do |t|
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "replies", ["post_id"], name: "index_replies_on_post_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.boolean  "survived",   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "leader_id"
    t.string   "group"
  end

  add_index "teams", ["group"], name: "index_teams_on_group", using: :btree
  add_index "teams", ["name", "survived"], name: "index_teams_on_name_and_survived", using: :btree

  create_table "trials", force: true do |t|
    t.integer  "team_id"
    t.boolean  "passed",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "period_id"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "department"
    t.string   "from_class"
    t.string   "gender"
    t.string   "remember_token"
    t.integer  "phone_num",              limit: 8
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "id_num"
    t.boolean  "admin",                            default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
