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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120122052506) do

  create_table "locations", :force => true do |t|
    t.string   "borough_code"
    t.string   "status_order"
    t.string   "main_street"
    t.string   "from_street"
    t.string   "to_street"
    t.string   "cardinal_side"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "from_lat"
    t.float    "from_lon"
    t.float    "to_lat"
    t.float    "to_lon"
    t.float    "length"
  end

  create_table "signs", :force => true do |t|
    t.string   "borough_code"
    t.string   "status_order"
    t.integer  "sign_sequence"
    t.integer  "curb_distance"
    t.string   "arrow_cardinal"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
