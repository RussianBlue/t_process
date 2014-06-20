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

ActiveRecord::Schema.define(version: 20140620042039) do

  create_table "board_categories", force: true do |t|
    t.integer "category_id"
    t.string  "name"
  end

  create_table "boards", force: true do |t|
    t.integer  "project_id"
    t.integer  "category_id"
    t.string   "title",             limit: 100
    t.string   "pre_title",         limit: 10
    t.integer  "user_id"
    t.integer  "count_at",                      default: 0
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.integer  "curriculum_id"
    t.integer  "group_no"
    t.integer  "level"
    t.integer  "seq_no"
  end

  create_table "curriculums", force: true do |t|
    t.integer  "project_id"
    t.integer  "total",             default: 0
    t.string   "title"
    t.string   "c_code"
    t.string   "location",          default: "http://14.63.221.185/trigitcontents/"
    t.string   "start",             default: "index.html"
    t.string   "progress_type_ids"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_series", force: true do |t|
    t.integer  "frequency",  default: 1
    t.string   "period",     default: "monthly"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",         default: false
    t.text     "description"
    t.integer  "event_series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  add_index "events", ["event_series_id"], name: "index_fullcalendar_engine_events_on_event_series_id", using: :btree

  create_table "firewalls", force: true do |t|
    t.string   "remote_ip"
    t.boolean  "ip_access"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "m_type"
    t.string   "to"
    t.string   "from"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.integer  "curriculum_id"
    t.integer  "lesson"
    t.boolean  "content_use"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "p_data_file_name"
    t.string   "p_data_content_type"
    t.integer  "p_data_file_size"
    t.datetime "p_data_updated_at"
    t.string   "s_data_file_name"
    t.string   "s_data_content_type"
    t.integer  "s_data_file_size"
    t.datetime "s_data_updated_at"
  end

  create_table "progress_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "progresses", force: true do |t|
    t.integer  "curriculum_id"
    t.integer  "lesson"
    t.integer  "process"
    t.integer  "progress_type_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "years",       limit: 4
    t.string   "title"
    t.string   "p_code",      limit: 6
    t.boolean  "finish",                default: false
    t.datetime "finished_at"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "board_ids"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "user_curriculums", force: true do |t|
    t.integer "user_id"
    t.integer "curriculum_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                                               null: false
    t.string   "company",                limit: 50
    t.string   "role_type"
    t.string   "celp_no",                limit: 11
    t.string   "approval",                          default: "N"
    t.string   "authorize",                         default: "guest"
    t.integer  "sign_in_count",                     default: 0,       null: false
    t.string   "encrypted_password",                default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "curriculum_ids"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
