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

ActiveRecord::Schema.define(:version => 20121112002103) do

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.integer  "guitar"
    t.integer  "bass"
    t.integer  "vocals"
    t.integer  "overall"
    t.integer  "drums"
    t.integer  "keyboard"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "pro_guitar"
    t.integer  "pro_keyboard"
    t.integer  "pro_drums"
    t.integer  "pro_bass"
    t.integer  "pro_vocals"
  end

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.string   "genre"
    t.integer  "guitar_difficulty"
    t.integer  "bass_difficulty"
    t.integer  "song_difficulty"
    t.integer  "drums_difficulty"
    t.integer  "vocals_difficulty"
    t.integer  "keyboard_difficulty"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "pro_guitar_difficulty"
    t.integer  "pro_keyboard_difficulty"
    t.integer  "pro_drums_difficulty"
    t.integer  "pro_bass_difficulty"
    t.integer  "pro_vocals_difficulty"
    t.string   "artist"
  end

  create_table "songs_users", :id => false, :force => true do |t|
    t.integer "song_id"
    t.integer "user_id"
  end

  add_index "songs_users", ["song_id", "user_id"], :name => "index_songs_users_on_song_id_and_user_id"
  add_index "songs_users", ["user_id", "song_id"], :name => "index_songs_users_on_user_id_and_song_id"

# Could not dump table "users" because of following StandardError
#   Unknown type 'bool' for column 'is_admin'

end
