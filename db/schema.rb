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

ActiveRecord::Schema.define(version: 2020_02_28_144346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_account_permissions", force: :cascade do |t|
    t.bigint "access_account_id"
    t.bigint "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_account_id"], name: "index_access_account_permissions_on_access_account_id"
    t.index ["permission_id"], name: "index_access_account_permissions_on_permission_id"
  end

  create_table "access_accounts", force: :cascade do |t|
    t.string "name"
    t.bigint "approver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["approver_id"], name: "index_access_accounts_on_approver_id"
  end

  create_table "access_request_permissions", force: :cascade do |t|
    t.bigint "access_request_id"
    t.bigint "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_request_id"], name: "index_access_request_permissions_on_access_request_id"
    t.index ["permission_id"], name: "index_access_request_permissions_on_permission_id"
  end

  create_table "access_requests", force: :cascade do |t|
    t.bigint "access_account_id"
    t.bigint "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_account_id"], name: "index_access_requests_on_access_account_id"
    t.index ["request_id"], name: "index_access_requests_on_request_id"
  end

  create_table "end_users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_end_users_on_role_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_events", force: :cascade do |t|
    t.bigint "request_id"
    t.string "state"
    t.text "comment"
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_request_events_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "end_user_id"
    t.integer "requester_id"
    t.bigint "access_account_id"
    t.bigint "permission_id"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_account_id"], name: "index_requests_on_access_account_id"
    t.index ["end_user_id"], name: "index_requests_on_end_user_id"
    t.index ["permission_id"], name: "index_requests_on_permission_id"
    t.index ["requester_id"], name: "index_requests_on_requester_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "access_account_permissions", "access_accounts"
  add_foreign_key "access_account_permissions", "permissions"
  add_foreign_key "access_request_permissions", "access_requests"
  add_foreign_key "access_request_permissions", "permissions"
  add_foreign_key "access_requests", "access_accounts"
  add_foreign_key "access_requests", "requests"
  add_foreign_key "request_events", "requests"
  add_foreign_key "requests", "access_accounts"
  add_foreign_key "requests", "end_users"
  add_foreign_key "requests", "permissions"
  add_foreign_key "users", "roles"
end
