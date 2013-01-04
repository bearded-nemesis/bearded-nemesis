require 'json'

songs = JSON.parse(open('../tools/song_list.json').read)
  .uniq{|x| x["shortname"]}
  .map{|x| x["shortname"]}
players = %w[Bill Andy Nathan Becki]

File.open("playlist.dat", 'w') do |f|
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


  f.write "param max_songs := 75;\n"


  f.write "param ratings :=\n"
  f.write "[*,*]: "
  players.each do |player|
    f.write " #{player}"
  end
  f.write " :=\n"

  songs.each do |song|
    f.write song
    players.each do
      f.write " " + Random.rand(6).to_s
    end
    f.write "\n"
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