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

ActiveRecord::Schema.define(:version => 20121220232952) do

  create_table "admin_whitelists", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "rock_parties", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "eventDate"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rock_parties_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "rock_party_id"
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
    t.string   "artist"
    t.integer  "pro_guitar_difficulty"
    t.integer  "pro_keyboard_difficulty"
    t.integer  "pro_drums_difficulty"
    t.integer  "pro_bass_difficulty"
    t.integer  "pro_vocals_difficulty"
    t.integer  "year"
    t.date     "release_date"
    t.string   "source"
    t.string   "shortname"
  end

  create_table "songs_users", :id => false, :force => true do |t|
    t.integer "song_id"
    t.integer "user_id"
  end

  add_index "songs_users", ["song_id", "user_id"], :name => "index_songs_users_on_song_id_and_user_id"
  add_index "songs_users", ["user_id", "song_id"], :name => "index_songs_users_on_user_id_and_song_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "artist"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
