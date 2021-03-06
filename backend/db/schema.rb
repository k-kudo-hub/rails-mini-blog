# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_05_232559) do

  create_table "assets", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "file", null: false
    t.string "alt", limit: 40, default: "alt", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_assets_on_user_id"
  end

  create_table "blogs", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "subject", default: "untitled", null: false
    t.text "body"
    t.string "cover_image"
    t.integer "state_number", limit: 1, default: 0, null: false
    t.string "url", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_blogs_on_url", unique: true
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "stars", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "blog_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blog_id"], name: "index_stars_on_blog_id"
    t.index ["user_id", "blog_id"], name: "index_stars_on_user_id_and_blog_id", unique: true
    t.index ["user_id"], name: "index_stars_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "introduce", limit: 250
    t.text "picture"
    t.text "cover"
    t.string "uid"
    t.string "provider", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "link"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "assets", "users"
  add_foreign_key "blogs", "users"
  add_foreign_key "stars", "blogs"
  add_foreign_key "stars", "users"
end
