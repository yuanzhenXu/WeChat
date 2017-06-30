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

ActiveRecord::Schema.define(version: 20170630021625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_wechat_tags", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "wechat_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_wechat_tags_on_user_id"
    t.index ["wechat_tag_id"], name: "index_user_wechat_tags_on_wechat_tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "groupid"
    t.string "openid"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wechat_tag"
    t.string "password_digest"
    t.string "mobile"
    t.string "email"
  end

  create_table "wechat_sessions", force: :cascade do |t|
    t.string "openid", null: false
    t.string "hash_store"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["openid"], name: "index_wechat_sessions_on_openid", unique: true
  end

  create_table "wechat_tags", force: :cascade do |t|
    t.string "name"
    t.integer "user_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
