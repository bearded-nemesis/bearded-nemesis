
set songs;
set instruments;
set players;

param ratings{songs, players, instruments};
param player_count;

var results{songs, players, instruments}, binary;

maximize rating:
    sum{s in songs, p in players, i in instruments} results[s, p, i];

s.t. song_usage{s in songs}:
    sum{p in players, i in instruments} results[s, p, i] 
	= (sum{p in players, i in instruments} results[s, p, i] / player_count) * player_count ;

s.t. one_person_max_on_instrument{s in songs, i in instruments}:
	sum{p in players} results[s, p, i] <= 1;

s.t. one_instrument_per_song{s in songs, p in players}:
	sum{i in instruments} results[s, p, i] <= 1;
	
solve;

for {s in songs} {
	printf "%s\n", s;
    
	for {p in players} {
		printf "\t%s: ", p;
		for {i in instruments: results[s, p, i] = 1} {
			printf "%s", i;
		}
		
		printf "\n";
	}
}


data;

set songs := BURN GUILTY BREATH LAST MEDICATE ;
set players := BILL ANDY NATHAN ;
set instruments := GUITAR BASS DRUMS VOCALS ;

param player_count := 3;

param ratings :=
	[*,*,GUITAR]: BURN GUILTY BREATH LAST MEDICATE :=
			BILL     1      5      2    3        2
			ANDY     2      3      5    5        3
		  NATHAN     5      2      3    1        4
	[*,*,BASS]:   BURN GUILTY BREATH LAST MEDICATE :=
			BILL     4      1      2    2        3
			ANDY     5      3      3    3        4
		  NATHAN     1      2      5    1        5
	[*,*,DRUMS]:  BURN GUILTY BREATH LAST MEDICATE :=
			BILL     2      5      4    5        4
			ANDY     3      4      3    3        1
		  NATHAN     1      3      2    2        2 
	[*,*,VOCALS]:  BURN GUILTY BREATH LAST MEDICATE :=
			BILL     5      2      4    1        1
			ANDY     2      4      2    2        4
		  NATHAN     4      1      3    5        5 ;

end;
