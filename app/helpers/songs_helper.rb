module SongsHelper
  def show_ownership(song)
    if @owned_songs.any? {|owned| owned == song}
      text = "Yes"
      class_name = "label-success"
    else
      text = "No"
    end

    content_tag(:span, class: "ownership label #{class_name}",
                "data-url" => own_song_path(song)) do
      text
    end
  end
end
