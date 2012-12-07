
set songs;
set instruments;
set players;

param ratings{songs, players, instruments};

var results{songs, players, instruments}

maximize rating:
    sum{s in songs, p in players, i in instruments} results[s, p, i]

data;

set songs := BURN GUILTY BREATH LAST MEDICATE
set players := BILL ANDY NATHAN
set instruments := GUITAR BASS DRUMS

set ratings :=
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

end;