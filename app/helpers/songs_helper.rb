module SongsHelper
  def show_ownership(song)
    if @owned_songs.any? {|owned| owned == song}
      text = "I own it"
      class_name = "label-success"
    else
      text = "I don't own it"
    end

    content_tag(:span, class: "label #{class_name}",
                "data-url" => own_song_path(song)) do
      text
    end
  end
end
