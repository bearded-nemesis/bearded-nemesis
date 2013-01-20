class SongSelector
  require 'rglpk'
  require 'erb'

  def initialize(song_count)
    @song_count = song_count
  end

  def generate(ratings)
    f = write_data_file ratings

    begin
      selected_song_ids = []

      GlpkModel.execute MODEL_PATH, f.path do |problem, i|
        name = Glpk_wrapper.glp_get_col_name problem, i
        value = Glpk_wrapper.glp_get_col_prim problem, i

        if value.to_i == 1 and (match = /selected_songs\[([0-9]+)\]/.match name)
          puts name
          selected_song_ids << match[1].to_i
        end
      end
    ensure
      f.unlink
    end

    selected_song_ids
  end

  private

  MODEL_PATH = "#{Rails.root}/glpk_models/playlist.mod"

  def write_data_file ratings
    data = {
        max_songs: @song_count,
        ratings: ratings,
        songs: ratings.keys,
        players: ratings.values.first.keys
    }
    template = ERB.new DATA_TEMPLATE

    f = Tempfile.new('playlist')
    begin
      f.write template.result(data.instance_eval { binding })
    ensure
      f.close
      puts f.path
    end

    f
  end

  DATA_TEMPLATE = <<EOF
set songs := <%= data[:songs].join ' ' %>;
set players := <%= data[:players].join ' ' %>;
param max_songs := <%= data[:max_songs] %>;
param ratings :=
[*,*]: <%= data[:players].join ' ' %> :=
<% data[:songs].each do |song| %>
  <%= song %> <%= data[:ratings][song].values.join ' ' %>
<% end %>;
end;
EOF
end