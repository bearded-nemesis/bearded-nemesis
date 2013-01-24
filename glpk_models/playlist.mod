
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

end;
