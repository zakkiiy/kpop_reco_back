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

ActiveRecord::Schema[7.0].define(version: 2024_06_30_132510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.string "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_artists_on_channel_id", unique: true
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "kpop_video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kpop_video_id"], name: "index_favorites_on_kpop_video_id"
    t.index ["user_id", "kpop_video_id"], name: "index_favorites_on_user_id_and_kpop_video_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "kpop_videos", force: :cascade do |t|
    t.string "name", null: false
    t.string "video_id", null: false
    t.string "image", null: false
    t.bigint "view_count", null: false
    t.datetime "posted_at", null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "video_type", default: 0, null: false
    t.index ["artist_id"], name: "index_kpop_videos_on_artist_id"
    t.index ["video_id"], name: "index_kpop_videos_on_video_id", unique: true
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "favorites", "kpop_videos"
  add_foreign_key "favorites", "users"
  add_foreign_key "kpop_videos", "artists"
  add_foreign_key "playlists", "users"
end
