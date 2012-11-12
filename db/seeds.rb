# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
admin_user = User.create email: "admin@example.com",
                         password: "password",
                         is_admin: true
user = User.create email: "user@example.com",
                   password: "password"

Song.delete_all
song1 = Song.create artist: "The Gathering",
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