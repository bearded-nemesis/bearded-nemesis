require 'yaml'

song_file = "/home/andrew/work/bearded-nemesis/tools/songs.yaml"
songs = YAML::load(File.open(song_file))

def difficulty(diff)
  return 0 if diff == 'zerodots'
  return 1 if diff == 'onedot'
  return 2 if diff == 'twodots'
  return 3 if diff == 'threedots'
  return 4 if diff == 'fourdots'
  return 5 if diff == 'fivedots'
  return 6 if diff == 'devils'
  return nil
end

songs.each do |song|
  #puts song
  #puts song[:difficulties]["keys"]
  #puts difficulty(song[:difficulties]["keys"])

  puts "Adding #{song["fullname"]}..."

  values = {}
  values[:shortname] =  song["shortname"]
  values[:bass_difficulty] =  difficulty(song[:difficulties]["bass"]) if difficulty(song[:difficulties]["bass"])
  values[:drums_difficulty] =  difficulty(song[:difficulties]["drums"]) if difficulty(song[:difficulties]["drums"])
  values[:genre] =  song[:genre]
  values[:guitar_difficulty] =  difficulty(song[:difficulties]["guitar"]) if difficulty(song[:difficulties]["guitar"])
  values[:keyboard_difficulty] =  difficulty(song[:difficulties]["keys"]) if difficulty(song[:difficulties]["keys"])
  values[:name] =  song["fullname"]
  values[:artist] =  song[:artist_name]
  values[:song_difficulty] =  difficulty(song[:difficulties]["song"]) if difficulty(song[:difficulties]["song"])
  values[:vocals_difficulty] =  difficulty(song[:difficulties]["vocals"]) if difficulty(song[:difficulties]["vocals"])
  values[:pro_keyboard_difficulty] =  difficulty(song[:difficulties]["pro_keys"]) if difficulty(song[:difficulties]["pro_keys"])
  values[:pro_drums_difficulty] =  difficulty(song[:difficulties]["pro_drums"]) if difficulty(song[:difficulties]["pro_drums"])
  values[:pro_guitar_difficulty] =  difficulty(song[:difficulties]["pro_guitar"]) if difficulty(song[:difficulties]["pro_guitar"])
  values[:pro_bass_difficulty] =  difficulty(song[:difficulties]["pro_bass"]) if difficulty(song[:difficulties]["pro_bass"])
  values[:pro_vocals_difficulty] =  difficulty(song[:difficulties]["pro_vocals"]) if difficulty(song[:difficulties]["pro_vocals"])
  values[:year] =  song[:year]
  values[:release_date] =  song[:release_date]
  values[:source] =  song[:source]


  #puts values

  Song.create! values

end