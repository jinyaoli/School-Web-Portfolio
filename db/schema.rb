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

ActiveRecord::Schema.define(version: 20170403025605) do

  create_table "comments", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "statement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "comment_id"
  end

  create_table "commits", force: :cascade do |t|
    t.string   "author"
    t.string   "date"
    t.string   "revision"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "project_file_id"
    t.string   "message"
  end

  create_table "project_files", force: :cascade do |t|
    t.string   "name"
    t.integer  "size"
    t.string   "path"
    t.string   "file_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "up_votes", force: :cascade do |t|
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_up_votes_on_comment_id"
  end

end