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

ActiveRecord::Schema.define(version: 20160604163258) do

  create_table "courses", force: :cascade do |t|
    t.integer  "crn",                 null: false
    t.string   "course_name",         null: false
    t.integer  "course_num",          null: false
    t.string   "type_tag"
    t.integer  "max_credits",         null: false
    t.integer  "min_credits"
    t.string   "instructor"
    t.string   "notes"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "datetime_id",         null: false
    t.integer  "department_id",       null: false
    t.integer  "group_satisfying_id", null: false
    t.integer  "location_id",         null: false
  end

  add_index "courses", ["datetime_id"], name: "index_courses_on_datetime_id"
  add_index "courses", ["department_id"], name: "index_courses_on_department_id"
  add_index "courses", ["group_satisfying_id"], name: "index_courses_on_group_satisfying_id"
  add_index "courses", ["location_id"], name: "index_courses_on_location_id"

  create_table "datetimes", force: :cascade do |t|
    t.integer  "course_id",  null: false
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "monday",     null: false
    t.boolean  "tuesday",    null: false
    t.boolean  "wednesday",  null: false
    t.boolean  "thursday",   null: false
    t.boolean  "friday",     null: false
    t.boolean  "saturday",   null: false
    t.boolean  "sunday",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.integer  "course_id",  null: false
    t.string   "code",       null: false
    t.string   "full_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_satisfyings", force: :cascade do |t|
    t.integer  "course_id",  null: false
    t.boolean  "AL",         null: false
    t.boolean  "SCC",        null: false
    t.boolean  "SC",         null: false
    t.boolean  "AC",         null: false
    t.boolean  "IP",         null: false
    t.boolean  "IC",         null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "course_id",       null: false
    t.boolean  "online",          null: false
    t.integer  "seats_available", null: false
    t.integer  "seats_max",       null: false
    t.string   "building"
    t.string   "room"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
