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

ActiveRecord::Schema.define(version: 20150804122205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.text     "description"
    t.string   "renter"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "type_apartment"
    t.integer  "price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "city_id"
    t.integer  "area_id"
    t.string   "street"
    t.string   "house"
    t.string   "repair"
    t.boolean  "furniture"
    t.date     "date_rent"
    t.string   "source"
    t.integer  "foreign_id"
    t.string   "url_source"
  end

  add_index "apartments", ["area_id"], name: "index_apartments_on_area_id", using: :btree
  add_index "apartments", ["city_id"], name: "index_apartments_on_city_id", using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assets", force: :cascade do |t|
    t.integer  "apartment_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "assets", ["apartment_id"], name: "index_assets_on_apartment_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "apartments", "areas"
  add_foreign_key "apartments", "cities"
  add_foreign_key "assets", "apartments"
end
