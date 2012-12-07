
set songs;
set instruments;
set players;

param ratings{players, songs, instruments};
param player_count;
param max_songs;

var results{players, songs, instruments}, binary;
var selected_songs{songs}, binary;
var players_instruments{players, instruments}, binary;

maximize rating:
    sum{s in songs, p in players, i in instruments} results[p, s, i] * ratings[p, s, i];

/* Ensure we don't have players in songs that weren't picked */
s.t. song_usage{s in songs}:
    sum{p in players, i in instruments} results[p, s, i] = selected_songs[s] * player_count ;

/* Make sure that we've picked the amount of songs requested */
s.t. enforce_max_songs:
	sum{s in songs} selected_songs[s] = max_songs ;

/* Make sure that there aren't more than one player on an instrument */
s.t. one_person_max_on_instrument{s in songs, i in instruments}:
	sum{p in players} results[p, s, i] <= 1;

/* Make sure that a single player isn't playing more than one instrument */
s.t. one_instrument_per_song{s in songs, p in players}:
	sum{i in instruments} results[p, s, i] <= 1;

/* Make sure that a player isn't selected to play more than once instrument for the set list */
s.t. same_instrument_for_player{p in players}:
	sum{i in instruments} players_instruments[p, i] = 1;
/* Make sure we enforce that each player can play one instrument in the results */
s.t. same_instrument_for_player2{i in instruments, p in players}:
	sum{s in songs} results[p, s, i] = max_songs * players_instruments[p, i];

solve;

for {s in songs: selected_songs[s] = 1} {
	printf "%s\n", s;
    
	for {p in players} {
		printf "\t%s: ", p;
		for {i in instruments: results[p, s, i] = 1} {
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

end;
