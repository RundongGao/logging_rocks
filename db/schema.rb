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

ActiveRecord::Schema.define(version: 20151111024332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "climbers", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "public",                 default: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "climbers", ["email"], name: "index_climbers_on_email", unique: true, using: :btree
  add_index "climbers", ["reset_password_token"], name: "index_climbers_on_reset_password_token", unique: true, using: :btree

  create_table "finishes", force: :cascade do |t|
    t.integer  "training_id", null: false
    t.string   "catagory"
    t.integer  "value"
    t.string   "difficulty"
    t.datetime "created_at"
  end

  add_index "finishes", ["catagory"], name: "index_finishes_on_catagory", using: :btree
  add_index "finishes", ["difficulty"], name: "index_finishes_on_difficulty", using: :btree
  add_index "finishes", ["training_id"], name: "index_finishes_on_training_id", using: :btree

  create_table "trainings", force: :cascade do |t|
    t.date     "date",       null: false
    t.integer  "climber_id", null: false
    t.datetime "created_at"
  end

  add_index "trainings", ["climber_id"], name: "index_trainings_on_climber_id", using: :btree
  add_index "trainings", ["date"], name: "index_trainings_on_date", using: :btree

end
