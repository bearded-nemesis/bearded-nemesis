require 'json'

songs = JSON.parse(open('../tools/song_list.json').read)
  .uniq{|x| x["shortname"]}
  .map{|x| x["shortname"]}
  .take(50)
players = %w[Bill Andy Nathan Becki]
instruments = %w[Guitar Bass Drums Vocals Keyboard]

File.open("model_data.dat", 'w') do |f|
  f.write "set songs :="
  songs.each do |song|
    f.write " " + song.to_s + "\n"
  end
  f.write " ;\n"


  f.write "set players :="
  players.each do |player|
    f.write " " + player
  end
  f.write " ;\n"


  f.write "set instruments :="
  instruments.each do |instrument|
    f.write " " + instrument
  end
  f.write " ;\n"


  f.write "param player_count := #{players.length};\n"
  f.write "param max_songs := 15;\n"


  f.write "param ratings :=\n"
  songs.each do |song|
    f.write "[*,#{song},*]: "
    instruments.each do |instrument|
      f.write " #{instrument}"
    end
    f.write " :=\n"

    players.each do |player|
      f.write player
      instruments.each do
        f.write " " + Random.rand(6).to_s
      end
      f.write "\n"
    end
  end
  f.write ";\n"
end




=begin
set songs := BURN GUILTY BREATH LAST MEDICATE ;
set players := BILL ANDY NATHAN ;
set instruments := GUITAR BASS DRUMS VOCALS ;

param player_count := 3;
param max_songs := 3;

param ratings :=
	[*,*,GUITAR]: BURN GUILTY BREATH LAST MEDICATE :=
			BILL     1      4      2    3        5
			ANDY     2      3      5    5        5
		  NATHAN     5      2      3    1        5
	[*,*,BASS]:   BURN GUILTY BREATH LAST MEDICATE :=
			BILL     4      4      2    2        5
			ANDY     5      3      3    3        5
		  NATHAN     1      3      5    1        5
	[*,*,DRUMS]:  BURN GUILTY BREATH LAST MEDICATE :=
			BILL     2      5      4    5        4
			ANDY     3      4      3    3        5
		  NATHAN     1      3      2    2        5
	[*,*,VOCALS]:  BURN GUILTY BREATH LAST MEDICATE :=
			BILL     5      2      4    1        5
			ANDY     2      4      2    2        4
		  NATHAN     4      5      3    5        5 ;
=end