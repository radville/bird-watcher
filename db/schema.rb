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

ActiveRecord::Schema.define(version: 20190907154244) do

  create_table "bird_sightings", force: :cascade do |t|
    t.string  "common_name"
    t.string  "scientific_name"
    t.date    "date"
    t.time    "time"
    t.string  "location"
    t.string  "description"
    t.integer "user_id"
  end

  create_table "birds", force: :cascade do |t|
    t.string "scientific_name"
    t.string "common_name"
    t.string "order"
    t.string "family"
    t.string "url"
    t.string "img_src"
    t.string "credit"
    t.string "license_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
  end

end
