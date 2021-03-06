# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_19_132702) do

  create_table "arranges", force: :cascade do |t|
    t.integer "video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["video_id"], name: "index_arranges_on_video_id"
  end

  create_table "arranges_clips", id: false, force: :cascade do |t|
    t.integer "arrange_id"
    t.integer "clip_id"
    t.index ["arrange_id"], name: "index_arranges_clips_on_arrange_id"
    t.index ["clip_id"], name: "index_arranges_clips_on_clip_id"
  end

  create_table "arranges_editors", id: false, force: :cascade do |t|
    t.integer "arrange_id"
    t.integer "editor_id"
    t.index ["arrange_id"], name: "index_arranges_editors_on_arrange_id"
    t.index ["editor_id"], name: "index_arranges_editors_on_editor_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "channel", null: false
    t.integer "platform_id", null: false
    t.integer "member_id"
    t.integer "editor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel", "platform_id"], name: "index_channels_on_channel_and_platform_id", unique: true
    t.index ["channel"], name: "index_channels_on_channel"
    t.index ["editor_id"], name: "index_channels_on_editor_id"
    t.index ["member_id"], name: "index_channels_on_member_id"
    t.index ["platform_id"], name: "index_channels_on_platform_id"
  end

  create_table "clips", force: :cascade do |t|
    t.integer "in_time"
    t.integer "out_time"
    t.integer "live_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["live_id"], name: "index_clips_on_live_id"
  end

  create_table "editors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_editors_on_name"
  end

  create_table "lives", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start_at", null: false
    t.integer "duration"
    t.integer "channel_id", null: false
    t.integer "room_id", null: false
    t.integer "video_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cover"
    t.index ["channel_id"], name: "index_lives_on_channel_id"
    t.index ["duration"], name: "index_lives_on_duration"
    t.index ["room_id"], name: "index_lives_on_room_id"
    t.index ["start_at"], name: "index_lives_on_start_at"
    t.index ["title"], name: "index_lives_on_title"
    t.index ["video_id"], name: "index_lives_on_video_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar", default: "", null: false
    t.string "color_main"
    t.string "color_sub"
    t.boolean "graduated", default: false, null: false
    t.index ["name"], name: "index_members_on_name"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "platform", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room", null: false
    t.integer "platform_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id"], name: "index_rooms_on_platform_id"
    t.index ["room", "platform_id"], name: "index_rooms_on_room_and_platform_id", unique: true
    t.index ["room"], name: "index_rooms_on_room"
  end

  create_table "videos", force: :cascade do |t|
    t.string "video"
    t.string "title"
    t.integer "duration"
    t.integer "platform_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["duration"], name: "index_videos_on_duration"
    t.index ["platform_id"], name: "index_videos_on_platform_id"
    t.index ["title"], name: "index_videos_on_title"
    t.index ["video"], name: "index_videos_on_video"
  end

  add_foreign_key "arranges", "videos"
  add_foreign_key "channels", "editors"
  add_foreign_key "channels", "members"
  add_foreign_key "channels", "platforms"
  add_foreign_key "clips", "lives"
  add_foreign_key "lives", "channels"
  add_foreign_key "lives", "rooms"
  add_foreign_key "lives", "videos"
  add_foreign_key "rooms", "platforms"
  add_foreign_key "videos", "platforms"
end
