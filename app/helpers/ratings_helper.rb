module RatingsHelper
  def get_ratings_url(song, rating)
    if rating.nil?
      new_song_rating_path(song, :format => "json")
    else
      edit_song_rating_path(song, rating, :format => "json")    
    end    
  end
  
  def get_ratings_method(rating)
    if rating.nil?
      "POST"
    else
      "PUT"  
    end
  end
end
