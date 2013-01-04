
set songs;
set players;

param ratings{songs, players};
param player_count; /* How many players do we have? */
param max_songs; /* How many songs do we want? */

var selected_songs{songs}, binary;

maximize rating:
    sum{s in songs, p in players} selected_songs[s] * ratings[s, p];

/* Ensure we don't have players in songs that weren't picked */
s.t. song_usage:
    sum{s in songs} selected_songs[s] = max_songs ;

solve;

for {s in songs: selected_songs[s] = 1} {
	printf "%s\n", s;
}


data;

set songs := BURN GUILTY BREATH LAST MEDICATE ;
set players := BILL ANDY NATHAN ;

param max_songs := 3;

param ratings :=
	[*,*]: BURN GUILTY BREATH LAST MEDICATE :=
			BILL     1      4      2    3        5
			ANDY     2      3      5    5        5
		  NATHAN     5      2      3    1        5
;
end;
