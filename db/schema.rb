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

ActiveRecord::Schema.define(version: 20170405175054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drafts", force: :cascade do |t|
    t.string   "recipient_email"
    t.string   "topic"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_drafts_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.string   "topic"
    t.text     "text"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "recipient_id"
    t.boolean  "is_read?",     default: false
    t.index ["sender_id"], name: "index_messages_on_sender_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "drafts", "users"
  add_foreign_key "messages", "users", column: "sender_id"
end
