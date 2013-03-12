# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Admin::Whitelist.delete_all
Admin::Whitelist.create email: "admin@example.com"
Admin::Whitelist.create email: "user@example.com"
Admin::Whitelist.create email: "bro@example.com"

User.delete_all
admin_user = User.create email: "admin@example.com",
                         password: "password",
                         admin: true
user = User.create email: "user@example.com",
                   password: "password"
bro = User.create email: "bro@example.com",
                  password: "yousuck"

Song.delete_all
song1 = Song.create artist: "The Gathering",
                    shortname: "gather",
                    name: "Third Chance",
                    genre: "Rock",
                    bass_difficulty: 1,
                    drums_difficulty: 2,
                    guitar_difficulty: 3,
                    keyboard_difficulty: 4,
                    vocals_difficulty: 5,
                    song_difficulty: 6,
                    pro_keyboard_difficulty: 0,
                    pro_drums_difficulty: 1,
                    pro_guitar_difficulty: 2,
                    pro_bass_difficulty: 3,
                    pro_vocals_difficulty: 4

song2 = Song.create artist: "Muse",
                    shortname: "born",
                    name: "New Born",
                    genre: "Alternative",
                    bass_difficulty: 5,
                    drums_difficulty: 6,
                    guitar_difficulty: 0,
                    keyboard_difficulty: 1,
                    vocals_difficulty: 2,
                    song_difficulty: 3,
                    pro_keyboard_difficulty: 4,
                    pro_drums_difficulty: 5,
                    pro_guitar_difficulty: 6,
                    pro_bass_difficulty: 0,
                    pro_vocals_difficulty: 1

song3 = Song.create artist: "Nine Inch Nails",
                    shortname: "down",
                    name: "Down in It",
                    genre: "Industrial",
                    bass_difficulty: 5,
                    drums_difficulty: 6,
                    guitar_difficulty: 0,
                    keyboard_difficulty: 1,
                    vocals_difficulty: 2,
                    song_difficulty: 3,
                    pro_keyboard_difficulty: 4,
                    pro_drums_difficulty: 5,
                    pro_guitar_difficulty: 6,
                    pro_bass_difficulty: 0,
                    pro_vocals_difficulty: 1

song1.users << user
song2.users << admin_user

song1.ratings.build overall: 2,
                    user: admin_user
song1.save!
song2.ratings.build bass: 3,
                    user: user
song2.save!

Playlist.delete_all
playlist1 = Playlist.create user: bro,
                            name: "Kick Ass Playlist #1"

PlaylistSong.delete_all
playlistSong1 = PlaylistSong.create song: song1,
                                    playlist: playlist1,
                                    bass_rocker: bro

playlist1.songs << playlistSong1