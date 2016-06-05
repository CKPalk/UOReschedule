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

ActiveRecord::Schema.define(version: 20160604034302) do

  create_table "courses", force: :cascade do |t|
    t.integer "crn",         null: false
    t.string  "course_name", null: false
    t.integer "course_num",  null: false
    t.string  "type_tag"
    t.integer "max_credits", null: false
    t.integer "min_credits"
    t.string  "instructor"
    t.string  "notes"
  end

  create_table "datetimes", force: :cascade do |t|
    t.integer "course_id"
    t.time    "start_time"
    t.time    "end_time"
    t.boolean "monday",     null: false
    t.boolean "tuesday",    null: false
    t.boolean "wednesday",  null: false
    t.boolean "thursday",   null: false
    t.boolean "friday",     null: false
    t.boolean "saturday",   null: false
    t.boolean "sunday",     null: false
  end

  add_index "datetimes", ["course_id"], name: "index_datetimes_on_course_id"

  create_table "departments", force: :cascade do |t|
    t.integer "course_id"
    t.string  "code",      null: false
    t.string  "full_name", null: false
  end

  add_index "departments", ["course_id"], name: "index_departments_on_course_id"

  create_table "group_satisfyings", force: :cascade do |t|
    t.integer "course_id"
    t.boolean "AL",        null: false
    t.boolean "SCC",       null: false
    t.boolean "SC",        null: false
    t.boolean "AC",        null: false
    t.boolean "IP",        null: false
    t.boolean "IC",        null: false
  end

  add_index "group_satisfyings", ["course_id"], name: "index_group_satisfyings_on_course_id"

  create_table "locations", force: :cascade do |t|
    t.integer "course_id"
    t.boolean "online",          null: false
    t.integer "seats_available", null: false
    t.integer "seats_max",       null: false
    t.string  "building"
    t.string  "room"
  end

  add_index "locations", ["course_id"], name: "index_locations_on_course_id"

end
