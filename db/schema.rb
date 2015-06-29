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

ActiveRecord::Schema.define(version: 20150629104943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "background_jobs", force: :cascade do |t|
    t.integer  "user_id"
    t.jsonb    "data"
    t.string   "status"
    t.string   "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "internal_accounts", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "internal_accounts", ["username"], name: "index_internal_accounts_on_username", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "spammers", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "comment",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spammers", ["username"], name: "index_spammers_on_username", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.jsonb    "cache"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vip_domains", force: :cascade do |t|
    t.string   "domain",     limit: 255
    t.string   "username",   limit: 255
    t.string   "category",   limit: 255
    t.string   "notes",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vip_domains", ["domain"], name: "index_vip_domains_on_domain", unique: true, using: :btree

  create_table "whitelisted_addresses", force: :cascade do |t|
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
