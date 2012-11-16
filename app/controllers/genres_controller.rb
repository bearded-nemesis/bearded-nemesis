class GenresController < ApplicationController
  def index
    @genres = Song.uniq.pluck :genre
  end
end
