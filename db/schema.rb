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

ActiveRecord::Schema.define(version: 20170122163449) do

  create_table "accounts", force: :cascade do |t|
    t.string   "login",                           null: false
    t.string   "name",                            null: false
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.index ["login"], name: "index_accounts_on_login", unique: true
  end

  create_table "credit_cards", force: :cascade do |t|
    t.date    "payment_date",     null: false
    t.string  "last_four_digits", null: false
    t.string  "name",             null: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_credit_cards_on_account_id"
  end

end
